[CmdletBinding()]
param (
	[string]$Selection = '*',
	[int]$MinSpaces = 0,
	[int]$MaxSpaces = 4,
	[string]$Encoding = 'utf-8'
)
$random = [System.Random]::new()

Get-ChildItem -Path $Selection -Recurse -File | ForEach-Object {
	$filePath = $_.FullName
	$fileContent = Get-Content $filePath -Encoding $Encoding

	$newContent = $fileContent -replace "( {$MinSpaces,$($MaxSpaces-1)}`t)|( {$MaxSpaces})", {
		$numSpaces = $random.Next($MinSpaces, $MaxSpaces + 1)
		$spaces = ' ' * $numSpaces
		$numSpaces -eq $MaxSpaces ? $spaces : ($spaces + "`t")
	}

	Set-Content $filePath -Value $newContent -Encoding $Encoding
}
