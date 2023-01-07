function Install-Hugo() {
  <#
    .SYNOPSIS
      Installing Hugo Extended from GitHub.

    .DESCRIPTION

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

  ${VER} = "${Version}"                             # Hugo version.
  ${DIR} = "${PSScriptRoot}\App"                    # Local Hugo directory.
  ${ZIP} = "hugo_extended_${VER}_windows-amd64.zip" # Hugo ZIP file.

  # Hugo download URL.
  ${URL} = "https://github.com/gohugoio/hugo/releases/download/v${VER}/${ZIP}"

  if ( Test-Path -Path "${DIR}" ) { Remove-Item -Path "${DIR}" -Recurse -Force }

  # Create app directory.
  Write-Information -MessageData "Create directory: '${DIR}'..." -InformationAction "Continue"
  New-Item -Path "${DIR}" -ItemType "Directory" -Force | Out-Null

  # Download Hugo ZIP from GitHub.
  Write-Information -MessageData "Download Hugo Extended: '${ZIP}'..." -InformationAction "Continue"
  Invoke-WebRequest "${URL}" -OutFile "${DIR}\${ZIP}"

  # Expanding Hugo ZIP.
  Write-Information -MessageData "Expand: '${ZIP}'..." -InformationAction "Continue"
  Expand-Archive -Path "${DIR}\${ZIP}" -DestinationPath "${DIR}"

  # Remove Hugo ZIP.
  Write-Information -MessageData "Remove: '${ZIP}'..." -InformationAction "Continue"
  Remove-Item -Path "${DIR}\${ZIP}";
}

function Start-HugoServer() {
  <#
    .SYNOPSIS
      Starting Hugo server.

    .DESCRIPTION

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

  # Hugo executable file.
  ${APP} = "${PSScriptRoot}\App\hugo.exe"

  # Composing a app command.
  ${CMD} = @( "server", "-D", "-p ${Port}", "--printI18nWarnings", "--cacheDir '${CacheDir}'", "--gc" )

  # Checking if a 'hugo.exe' exist.
  if ( -not ( Test-Path -Path "${APP}" -PathType "Leaf" ) ) {
    Write-Error -Message "'hugo.exe' not found! Please install Hugo: 'Get-Help Install-Hugo'." -ErrorAction "Stop"
  }

  # Running a app.
  & "${APP}" ${CMD}
}
