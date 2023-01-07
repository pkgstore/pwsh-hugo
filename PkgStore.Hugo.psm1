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

  ${VER} = "${Version}"
  ${DIR} = "${PSScriptRoot}\App"
  ${ZIP} = "hugo_extended_${VER}_windows-amd64.zip"
  ${URL} = "https://github.com/gohugoio/hugo/releases/download/v${VER}/${ZIP}"

  if ( Test-Path -Path "${DIR}" ) { Remove-Item -Path "${DIR}" -Recurse -Force }

  Write-Information -MessageData "Create directory: '${DIR}'..." -InformationAction "Continue"
  New-Item -Path "${DIR}" -ItemType "Directory" -Force | Out-Null

  Write-Information -MessageData "Download Hugo Extended: '${ZIP}'..." -InformationAction "Continue"
  Invoke-WebRequest "${URL}" -OutFile "${DIR}\${ZIP}"

  Write-Information -MessageData "Expand: '${ZIP}'..." -InformationAction "Continue"
  Expand-Archive -Path "${DIR}\${ZIP}" -DestinationPath "${DIR}"

  Write-Information -MessageData "Remove: '${ZIP}'..." -InformationAction "Continue"
  Remove-Item -Path "${DIR}\${ZIP}";
}

function Start-HugoServer() {
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
    [Alias('P')]
    [string]${Port},

    [Alias('CD')]
    [string]${CacheDir} = "$( Get-Location )\cache"
  )

  ${APP} = "${PSScriptRoot}\App\hugo.exe"
  ${CMD} = @( "server", "-D", "-p ${Port}", "--printI18nWarnings", "--cacheDir ${CacheDir}", "--gc" )

  if ( -not ( Test-Path -Path "${APP}" -PathType "Leaf" ) ) {
    Write-Error -Message "'hugo.exe' not found! Please install Hugo: 'Install-Hugo'." -ErrorAction "Stop"
  }

  & "${APP}" ${CMD}
}
