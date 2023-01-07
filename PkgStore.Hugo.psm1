function Install-Hugo() {
  <#
    .SYNOPSIS
      Install Hugo.

    .DESCRIPTION
      Installing Hugo Extended from GitHub.

    .PARAMETER Version
      Hugo version.
      Alias: '-V'.

    .EXAMPLE
      Install-Hugo -V '0.109.0'

    .LINK
      Package Store: https://github.com/pkgstore

    .NOTES
      Author: Kitsune Solar <mail@kitsune.solar>
  #>

  [CmdletBinding()]

  Param(
    [Parameter(Mandatory)]
    [ValidatePattern('^((\d+)\.(\d+)\.(\d+))$')]
    [Alias('V')]
    [string]${Version}
  )

  ${VER} = "${Version}"
  ${DIR} = "${PSScriptRoot}\App"
  ${ZIP} = "hugo_extended_${VER}_windows-amd64.zip"
  ${URL} = "https://github.com/gohugoio/hugo/releases/download/v${VER}/${ZIP}"

  if ( Test-Path -Path "${DIR}" ) { Remove-Item -Path "${DIR}" -Recurse -Force }

  # Create app directory.
  Write-Information -MessageData "Create directory: '${DIR}'..." -InformationAction "Continue"
  New-Item -Path "${DIR}" -ItemType "Directory" -Force | Out-Null

  # Download Hugo ZIP from GitHub.
  Write-Information -MessageData "Download Hugo Extended: '${ZIP}'..." -InformationAction "Continue"
  Invoke-WebRequest "${URL}" -OutFile "${DIR}\${ZIP}"

  # Expand Hugo ZIP.
  Write-Information -MessageData "Expand: '${ZIP}'..." -InformationAction "Continue"
  Expand-Archive -Path "${DIR}\${ZIP}" -DestinationPath "${DIR}"

  # Remove Hugo ZIP.
  Write-Information -MessageData "Remove: '${ZIP}'..." -InformationAction "Continue"
  Remove-Item -Path "${DIR}\${ZIP}";
}

function Start-HugoServer() {
  <#
    .SYNOPSIS
      Run Hugo server.

    .DESCRIPTION
      Starting Hugo server.

    .PARAMETER Port
      Hugo server port.
      Default: '1313'.
      Alias: '-P'.

    .PARAMETER CacheDir
      Path to Hugo server cache directory.
      Default: '$( Get-Location )\cache'.
      Alias: '-CD'.

    .EXAMPLE
      Start-HugoServer

    .EXAMPLE
      Start-HugoServer -P 1315 -CD 'D:\Hugo\Cache'

    .LINK
      Package Store: https://github.com/pkgstore

    .NOTES
      Author: Kitsune Solar <mail@kitsune.solar>
  #>

  [CmdletBinding()]

  Param(
    [Alias('P')]
    [int]${Port} = 1313,

    [Alias('CD')]
    [string]${CacheDir} = "$( Get-Location )\cache"
  )

  ${APP} = "${PSScriptRoot}\App\hugo.exe"
  ${CMD} = @( "server", "-D", "-p ${Port}", "--printI18nWarnings", "--cacheDir '${CacheDir}'", "--gc" )

  if ( -not ( Test-Path -Path "${APP}" -PathType "Leaf" ) ) {
    Write-Error -Message "'hugo.exe' not found! Please install Hugo: 'Get-Help Install-Hugo'." -ErrorAction "Stop"
  }

  & "${APP}" ${CMD}
}
