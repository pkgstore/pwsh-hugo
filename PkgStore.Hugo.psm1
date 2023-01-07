function Install-Hugo() {
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Version

    .EXAMPLE

    .LINK
      Package Store: https://github.com/pkgstore

    .NOTES
      Author: Kitsune Solar <mail@kitsune.solar>
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory)]
    [Alias('V')]
    [string]${Version}
  )

  ${DIR} = "${PSScriptRoot}\App"
  ${ZIP} = "hugo_extended_${Version}_windows-amd64.zip"
  ${URL} = "https://github.com/gohugoio/hugo/releases/download/v${Version}/${ZIP}"

  if ( Test-Path -Path "${DIR}" ) { Remove-Item -Path "${DIR}" -Recurse -Force }

  New-Item -Path "${DIR}" -ItemType "Directory" -Force | Out-Null
  Invoke-WebRequest "${URL}" -OutFile "${DIR}\${ZIP}"
  Expand-Archive -Path "${DIR}\${ZIP}" -DestinationPath "${DIR}"
  Remove-Item -Path "${DIR}\${ZIP}";
}
