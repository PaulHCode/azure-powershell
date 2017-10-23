﻿# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

. "$PSScriptRoot\GenerateTestModule.ps1"
. "$PSScriptRoot\DeliverModuleToAutomationAccount.ps1"

<#
.SYNOPSIS
Combines calls of the related functions together
.PARAMETER srcPath
Path to the solution src folder
.PARAMETER projectList
List of the projects to coolect test scripts from. 
Projects are azure-powershell\src\ResourceManager subfolders.
.EXAMPLE
GenerateAndUploadTestsModule `
    -srcPath "e:\git\azure-powershell\src\" `
    -projectList @('Compute', 'Storage','Network', 'KeyVault', 'Sql', 'Websites')
#>
function GenerateAndUploadTestsModule (
    [string] $srcPath
    ,[string[]] $projectList) {

    $moduleName  = 'AutomationTests'

    $modulePath = "$srcPath\Package\$moduleName"

    # projects are azure-powershell\src\ResourceManager subfolders 
    #$projectList = @('Compute', 'Storage','Network', 'KeyVault', 'Sql', 'Websites')

    GenerateTestsModule `
        -srcPath $srcPath `
        -targetPath $modulePath `
        -moduleName $moduleName `
        -projectList $projectList

    DeliverModuleToAutomationAccount `
        -modulePath $modulePath `
        -moduleName $moduleName

    CheckModuleProvisionState `
        -moduleList $moduleName `

}