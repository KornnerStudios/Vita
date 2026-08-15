#Requires -Version 5.1
[CmdletBinding()]
param(
	[Parameter(Mandatory = $true, Position = 0)]
	[ValidateNotNullOrEmpty()]
	[string] $Summary,

	[Parameter(Position = 1, ValueFromRemainingArguments = $true)]
	[AllowEmptyString()]
	[string[]] $Body = @(),

	[string] $RepoPath = "KSoft",

	[switch] $Amend,

	[switch] $NoVerify,

	[switch] $Preview
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$CoAuthorTrailer = "Co-authored-by: Copilot App <223556219+Copilot@users.noreply.github.com>"
$SessionTrailer = "Copilot-Session: 0edcd990-76f3-499b-8e47-a421a88fe7b2"

function Normalize-CommitBody {
	param(
		[string[]] $Lines
	)

	if ($null -eq $Lines -or $Lines.Count -eq 0) {
		return ""
	}

	$text = ($Lines -join "`n") -replace "`r`n", "`n" -replace "`r", "`n"
	return $text.Trim()
}

function Assert-NoCommitTrailers {
	param(
		[string] $Text,
		[string] $FieldName
	)

	if ($Text -match "(?mi)^(Co-authored-by|Copilot-Session):") {
		throw "$FieldName must not include commit trailers. This script appends the required trailer block."
	}
}

if ($Summary -match "[`r`n]") {
	throw "Summary must be exactly one line."
}

$Summary = $Summary.Trim()
if ([string]::IsNullOrWhiteSpace($Summary)) {
	throw "Summary must not be empty."
}

Assert-NoCommitTrailers $Summary "Summary"

$bodyText = Normalize-CommitBody $Body
Assert-NoCommitTrailers $bodyText "Body"

$messageParts = [System.Collections.Generic.List[string]]::new()
$messageParts.Add($Summary)

if ($bodyText.Length -gt 0) {
	$messageParts.Add("")
	$messageParts.Add($bodyText)
}

$messageParts.Add("")
$messageParts.Add($CoAuthorTrailer)
$messageParts.Add($SessionTrailer)

$commitMessage = $messageParts -join "`n"
$expectedTrailerBlock = "$CoAuthorTrailer`n$SessionTrailer"

if (-not $commitMessage.EndsWith($expectedTrailerBlock, [System.StringComparison]::Ordinal)) {
	throw "Commit message trailer block was not appended correctly."
}

if ($commitMessage -match "(?m)^Co-authored-by:.*\n\s*\nCopilot-Session:") {
	throw "Commit message trailers must be contiguous with no blank line between them."
}

if ($Preview) {
	$commitMessage
	return
}

$messageFile = New-TemporaryFile
try {
	$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
	[System.IO.File]::WriteAllText($messageFile.FullName, $commitMessage + "`n", $utf8NoBom)

	$gitArgs = @("-C", $RepoPath, "commit")
	if ($Amend) {
		$gitArgs += "--amend"
	}
	if ($NoVerify) {
		$gitArgs += "--no-verify"
	}
	$gitArgs += @("--file", $messageFile.FullName)

	& git @gitArgs
	if ($LASTEXITCODE -ne 0) {
		throw "git commit failed with exit code $LASTEXITCODE."
	}
}
finally {
	Remove-Item -LiteralPath $messageFile.FullName -Force -ErrorAction SilentlyContinue
}
