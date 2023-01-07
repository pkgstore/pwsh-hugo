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

  ${URL} = "https://github.com/gohugoio/hugo/releases/download/v${Version}/hugo_extended_${Version}_windows-amd64.zip"
  ${DIR} = "${PSScriptRoot}\hugo"
  ${HUGO} = "${DIR}\hugo.exe"

  if ( -not ( Test-Path -Path "${HUGO}" -PathType "Leaf" ) ) {
    Invoke-WebRequest "${URL}" -OutFile "${DIR}"
  }
}
