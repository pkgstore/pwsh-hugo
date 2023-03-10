@{
  RootModule = 'PkgStore.Hugo.psm1'
  ModuleVersion = '1.0.0'
  GUID = 'a9ccf01a-0394-42bf-b89b-65d134697a0d'
  Author = 'Kitsune Solar'
  CompanyName = 'v77 Development'
  Copyright = '(c) 2023 v77 Development. All rights reserved.'
  Description = 'PowerShell module for Hugo Extended.'
  PowerShellVersion = '7.1'
  RequiredModules = @('PkgStore.Kernel')
  FunctionsToExport = @('Install-Hugo', 'Start-HugoServer')
  PrivateData = @{
    PSData = @{
      Tags = @('pwsh', 'hugo')
      LicenseUri = 'https://github.com/pkgstore/pwsh-hugo/blob/main/LICENSE'
      ProjectUri = 'https://github.com/pkgstore/pwsh-hugo'
    }
  }
}
