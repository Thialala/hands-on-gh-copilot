# PostToolUse hook: runs dotnet test after file edits to .cs or .cshtml files
if (-not $Input) { $Input = [Console]::In.ReadToEnd() }
$Json = $Input | ConvertFrom-Json
$ToolName = $Json.toolName

# Only trigger after file edit operations
if ($ToolName -notmatch 'edit|create|replace|write') {
    exit 0
}

# Check if the edited file is a PolicyFlow source file
$FilePath = if ($Json.toolArgs.filePath) { $Json.toolArgs.filePath } elseif ($Json.toolArgs.path) { $Json.toolArgs.path } else { '' }
if (-not $FilePath) {
    exit 0
}

if ($FilePath -notmatch '\.(cs|cshtml)$') {
    exit 0
}

# Find the repo root
$RepoRoot = git rev-parse --show-toplevel 2>$null
if (-not $RepoRoot) {
    $RepoRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot))
}
Set-Location $RepoRoot

# Run the tests
$TestOutput = dotnet test tests/PolicyFlow.Tests --no-restore --verbosity quiet 2>&1 | Out-String
$ExitCode = $LASTEXITCODE

$ShortPath = Split-Path -Leaf $FilePath

if ($ExitCode -ne 0) {
    $Message = "Tests failed after editing $ShortPath. Output: $TestOutput"
    Write-Output "{`"systemMessage`": `"$($Message -replace '"','\"')`"}"
} else {
    if ($TestOutput -match 'Passed:\s+(\d+)') {
        $Passed = $Matches[1]
    } else {
        $Passed = 'all'
    }
    Write-Output "{`"systemMessage`": `"Tests passed ($Passed) after editing $ShortPath.`"}"
}
