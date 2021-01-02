#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.

$ErrorActionPreference = 'SilentlyContinue'

$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Warning
$Ask = "Do you want to elevate CleanWin? This is compulsory to ensure proper usage."

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    $Prompt = [System.Windows.MessageBox]::Show($Ask, "Elevation request", $Button, $ErrorIco) 
    Switch ($Prompt) {
        #This will setup Windows 10
        Yes {
            Write-Host "CleanWin has been elevated. Launching GUI..."
            Start-Sleep 1
            Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
            Exit
         }
        No {
            Break
            }
    }
}

# import library code - located relative to this script
Function dotInclude() {
    Param(
        [Parameter(Mandatory)]
        [string]$includeFile
    )
    # Look for the file in the same directory as this script
    $scriptPath = $PSScriptRoot
    if ( $PSScriptRoot -eq $null -and $psISE) {
        $scriptPath = (Split-Path -Path $psISE.CurrentFile.FullPath)
    }
    if ( test-path $scriptPath\$includeFile ) {
        # import and immediately execute the requested file
        . $scriptPath\$includeFile
    }
}


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

Function screen {
    Clear-Host
    Start-Sleep 1
    Write-Host "                                        CleanWin v0.3.4"
    Write-Warning "The GUI window might hang for extended periods of time while it's performing a task."
}

screen

### BEGIN GUI ###

$Form = New-Object System.Windows.Forms.Form
$Form.ClientSize = '610,565'
$Form.Text = "CleanWin v0.3.4"
$Form.TopMost = $false



############### APPS AND FEATURES ############################

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "               Apps and Features"
$Label2.AutoSize = $true
$Label2.Width = 25
$Label2.Height = 15
$Label2.Location = New-Object System.Drawing.Point(10, 10)
$Label2.Font = 'Segoe UI,12,style=Bold'

$UninstallAllBloatApps = New-Object System.Windows.Forms.Button
$UninstallAllBloatApps.Text = "Uninstall all bloat apps"
$UninstallAllBloatApps.Width = 140
$UninstallAllBloatApps.Height = 45
$UninstallAllBloatApps.Location = New-Object System.Drawing.Point(10, 38)
$UninstallAllBloatApps.Font = 'Segoe UI,10'

$UninstallAppsSelectively = New-Object System.Windows.Forms.Button
$UninstallAppsSelectively.Text = "Uninstall apps selectively"
$UninstallAppsSelectively.Width = 140
$UninstallAppsSelectively.Height = 45
$UninstallAppsSelectively.Location = New-Object System.Drawing.Point(150, 38)
$UninstallAppsSelectively.Font = 'Segoe UI,10'

$InstallChoco = New-Object System.Windows.Forms.Button
$InstallChoco.Text = "Install Chocolatey"
$InstallChoco.Width = 140
$InstallChoco.Height = 45
$InstallChoco.Location = New-Object System.Drawing.Point(10,83)
$InstallChoco.Font = 'Segoe UI,10'

$ChocInstall = New-Object System.Windows.Forms.Button
$ChocInstall.Text = "ChocInstall"
$ChocInstall.Width = 140
$ChocInstall.Height = 45
$ChocInstall.Location = New-Object System.Drawing.Point(150, 83)
$ChocInstall.Font = 'Segoe UI,10'

$InstallWSL = New-Object System.Windows.Forms.Button
$InstallWSL.Text = "Install WSL"
$InstallWSL.Width = 140
$InstallWSL.Height = 45
$InstallWSL.Location = New-Object System.Drawing.Point(150,128)
$InstallWSL.Font = 'Segoe UI,10'

$UninstallBloatFeatures = New-Object System.Windows.Forms.Button
$UninstallBloatFeatures.Text = "Uninstall bloat features"
$UninstallBloatFeatures.Width = 140
$UninstallBloatFeatures.Height = 45
$UninstallBloatFeatures.Location = New-Object System.Drawing.Point(10,128)
$UninstallBloatFeatures.Font = 'Segoe UI,10'



####################### PRIVACY & SECURITY ##########################

$Label3 = New-Object System.Windows.Forms.Label
$Label3.Text = "                        Privacy"
$Label3.AutoSize = $true
$Label3.Width = 25
$Label3.Height = 10
$Label3.Location = New-Object System.Drawing.Point(10,181)
$Label3.Font = 'Segoe UI,12,style=Bold'

$OOShutup10 = New-Object System.Windows.Forms.Button
$OOShutup10.Text = 'Apply O&OShutup10 config'
$OOShutup10.Width = 140
$OOShutup10.Height = 45
$OOShutup10.Location = New-Object System.Drawing.Point(10, 210)
$OOShutup10.Font = 'Segoe UI,10'

$HostsTelemetry = New-Object System.Windows.Forms.Button
$HostsTelemetry.Text = 'Block telemetry using hosts'
$HostsTelemetry.Width = 140
$HostsTelemetry.Height = 45
$HostsTelemetry.Location = New-Object System.Drawing.Point(150, 210)
$HostsTelemetry.Font = 'Segoe UI,10'

$DisableDataCollection = New-Object System.Windows.Forms.Button
$DisableDataCollection.Text = "Disable Data collection"
$DisableDataCollection.Width = 140
$DisableDataCollection.Height = 40
$DisableDataCollection.Location = New-Object System.Drawing.Point(10,255)
$DisableDataCollection.Font = 'Segoe UI,10'

$EnableDataCollection = New-Object System.Windows.Forms.Button
$EnableDataCollection.Text = "Enable Data collection"
$EnableDataCollection.Width = 140
$EnableDataCollection.Height = 40
$EnableDataCollection.Location = New-Object System.Drawing.Point(150,255)
$EnableDataCollection.Font = 'Segoe UI,10'

$DisableTelemetry = New-Object System.Windows.Forms.Button 
$DisableTelemetry.Text = "Disable Telemetry"
$DisableTelemetry.Width = 140
$DisableTelemetry.Height = 40
$DisableTelemetry.Location = New-Object System.Drawing.Point(10, 295)
$DisableTelemetry.Font = 'Segoe UI,10'

$EnableTelemetry = New-Object System.Windows.Forms.Button 
$EnableTelemetry.Text = "Enable Telemetry"
$EnableTelemetry.Width = 140
$EnableTelemetry.Height = 40
$EnableTelemetry.Location = New-Object System.Drawing.Point(150, 295)
$EnableTelemetry.Font = 'Segoe UI,10'

$FullBandwidth = New-Object System.Windows.Forms.Button 
$FullBandwidth.Text = "Release Bandwidth"
$FullBandwidth.Width = 140
$FullBandwidth.Height = 40
$FullBandwidth.Location = New-Object System.Drawing.Point(10, 335)
$FullBandwidth.Font = 'Segoe UI,10'

$ReserveBandwidth = New-Object System.Windows.Forms.Button 
$ReserveBandwidth.Text = "Reserve Bandwidth"
$ReserveBandwidth.Width = 140
$ReserveBandwidth.Height = 40
$ReserveBandwidth.Location = New-Object System.Drawing.Point(150, 335)
$ReserveBandwidth.Font = 'Segoe UI,10'



############## WINDOWS EXPLORER #################

$Label4 = New-Object System.Windows.Forms.Label
$Label4.Text = "                Windows Explorer"
$Label4.AutoSize = $true
$Label4.Width = 25
$Label4.Height = 10
$Label4.Location = New-Object System.Drawing.Point(320,8)
$Label4.Font = 'Segoe UI,12,style=Bold' 

$CleanExplorer = New-Object System.Windows.Forms.Button
$CleanExplorer.Text = "Clean Windows Explorer"
$CleanExplorer.Width = 140
$CleanExplorer.Height = 40
$CleanExplorer.Location = New-Object System.Drawing.Point(320,35)
$CleanExplorer.Font = 'Segoe UI,10'

$UndoCleanExplorer = New-Object System.Windows.Forms.Button
$UndoCleanExplorer.Text = "Revert Clean Windows Explorer"
$UndoCleanExplorer.Width = 140
$UndoCleanExplorer.Height = 40 
$UndoCleanExplorer.Location = New-Object System.Drawing.Point(460,35)
$UndoCleanExplorer.Font = 'Segoe UI,10'

$DisableStickyKeys = New-Object System.Windows.Forms.Button
$DisableStickyKeys.Text = "Disable Sticky keys"
$DisableStickyKeys.Width = 140
$DisableStickyKeys.Height = 40
$DisableStickyKeys.Location = New-Object System.Drawing.Point(320,75)
$DisableStickyKeys.Font = 'Segoe UI,10'

$EnableStickyKeys = New-Object System.Windows.Forms.Button
$EnableStickyKeys.Text = "Enable Sticky keys"
$EnableStickyKeys.Width = 140
$EnableStickyKeys.Height = 40
$EnableStickyKeys.Location = New-Object System.Drawing.Point(460,75)
$EnableStickyKeys.Font = 'Segoe UI,10'

$EnablePrtScrForSnip = New-Object System.Windows.Forms.Button
$EnablePrtScrForSnip.Text = "Use PrtScr to open Screen Snip"
$EnablePrtScrForSnip.Width = 140
$EnablePrtScrForSnip.Height = 40
$EnablePrtScrForSnip.Location = New-Object System.Drawing.Point(320,115)
$EnablePrtScrForSnip.Font = 'Segoe UI,10'

$DisablePrtScrForSnip = New-Object System.Windows.Forms.Button
$DisablePrtScrForSnip.Text = "Don't use PrtScr to open Screen snip"
$DisablePrtScrForSnip.Width = 140
$DisablePrtScrForSnip.Height = 40
$DisablePrtScrForSnip.Location = New-Object System.Drawing.Point(460,115)
$DisablePrtScrForSnip.Font = 'Segoe UI,10'

$Hide3DObjects = New-Object System.Windows.Forms.Button
$Hide3DObjects.Text = "Hide 3D objects"
$Hide3DObjects.Width = 140
$Hide3DObjects.Height = 40
$Hide3DObjects.Location = New-Object System.Drawing.Point(320,155)
$Hide3DObjects.Font = 'Segoe UI,10'

$Show3DObjects = New-Object System.Windows.Forms.Button
$Show3DObjects.Text = "Restore 3D objects"
$Show3DObjects.Width = 140
$Show3DObjects.Height = 40
$Show3DObjects.Location = New-Object System.Drawing.Point(460,155)
$Show3DObjects.Font = 'Segoe UI,10'

$ShowVerboseStatus = New-Object System.Windows.Forms.Button
$ShowVerboseStatus.Text = "Show verbose status"
$ShowVerboseStatus.Width = 140
$ShowVerboseStatus.Height = 40
$ShowVerboseStatus.Location = New-Object System.Drawing.Point(320,195)
$ShowVerboseStatus.Font = 'Segoe UI,10'

$HideVerboseStatus = New-Object System.Windows.Forms.Button
$HideVerboseStatus.Text = "Hide verbose status"
$HideVerboseStatus.Width = 140
$HideVerboseStatus.Height = 40
$HideVerboseStatus.Location = New-Object System.Drawing.Point(460,195)
$HideVerboseStatus.Font = 'Segoe UI,10'

$DisableBlurLockScreen = New-Object System.Windows.Forms.Button
$DisableBlurLockScreen.Text = "Turn off blur in lock screen"
$DisableBlurLockScreen.Width = 140
$DisableBlurLockScreen.Height = 40
$DisableBlurLockScreen.Location = New-Object System.Drawing.Point(320,235)
$DisableBlurLockScreen.Font = 'Segoe UI,10'

$EnableBlurLockScreen = New-Object System.Windows.Forms.Button
$EnableBlurLockScreen.Text = "Turn on blur in lock screen"
$EnableBlurLockScreen.Width = 140
$EnableBlurLockScreen.Height = 40
$EnableBlurLockScreen.Location = New-Object System.Drawing.Point(460,235)
$EnableBlurLockScreen.Font = 'Segoe UI,10'

$ShowSeconds = New-Object System.Windows.Forms.Button
$ShowSeconds.Text = "Show Seconds in Taskbar"
$ShowSeconds.Width = 140
$ShowSeconds.Height = 40
$ShowSeconds.Location = New-Object System.Drawing.Point(320,275)
$ShowSeconds.Font = 'Segoe UI,10'

$HideSeconds = New-Object System.Windows.Forms.Button
$HideSeconds.Text = "Hide Seconds in Taskbar"
$HideSeconds.Width = 140
$HideSeconds.Height = 40
$HideSeconds.Location = New-Object System.Drawing.Point(460,275)
$HideSeconds.Font = 'Segoe UI,10'



############# TASKS & SERVICES ###################

$Label5 = New-Object System.Windows.Forms.Label
$Label5.Text = "             Tasks and Services"
$Label5.AutoSize = $true
$Label5.Width = 25
$Label5.Height = 10
$Label5.Location = New-Object System.Drawing.Point(320,328)
$Label5.Font = 'Segoe UI,12,style=Bold' 

$DisableAutoUpdates = New-Object System.Windows.Forms.Button
$DisableAutoUpdates.Text = "Disable automatic updates"
$DisableAutoUpdates.Width = 140
$DisableAutoUpdates.Height = 40
$DisableAutoUpdates.Location = New-Object System.Drawing.Point(320,355)
$DisableAutoUpdates.Font = 'Segoe UI,10'

$EnableAutoUpdates = New-Object System.Windows.Forms.Button
$EnableAutoUpdates.Text = "Enable automatic updates"
$EnableAutoUpdates.Width = 140
$EnableAutoUpdates.Height = 40
$EnableAutoUpdates.Location = New-Object System.Drawing.Point(460,355)
$EnableAutoUpdates.Font = 'Segoe UI,10'

$DisableDefrag = New-Object System.Windows.Forms.Button
$DisableDefrag.Text = "Disable defragmentation"
$DisableDefrag.Width = 140
$DisableDefrag.Height = 44
$DisableDefrag.Location = New-Object System.Drawing.Point(320,395)
$DisableDefrag.Font = 'Segoe UI,10'

$EnableDefrag = New-Object System.Windows.Forms.Button
$EnableDefrag.Text = "Enable defragmentation"
$EnableDefrag.Width = 140
$EnableDefrag.Height = 44
$EnableDefrag.Location = New-Object System.Drawing.Point(460,395)
$EnableDefrag.Font = 'Segoe UI,10'

$DisableServices = New-Object System.Windows.Forms.Button
$DisableServices.Text = "Disable unnecessary services"
$DisableServices.Width = 140
$DisableServices.Height = 40
$DisableServices.Location = New-Object System.Drawing.Point(320,439)
$DisableServices.Font = 'Segoe UI,10'

$EnableServices = New-Object System.Windows.Forms.Button
$EnableServices.Text = "Enable unnecessary services"
$EnableServices.Width = 140
$EnableServices.Height = 40
$EnableServices.Location = New-Object System.Drawing.Point(460,439)
$EnableServices.Font = 'Segoe UI,10'

$DisableTasks = New-Object System.Windows.Forms.Button
$DisableTasks.Text = "Disable unnecessary tasks"
$DisableTasks.Width = 140
$DisableTasks.Height = 40
$DisableTasks.Location = New-Object System.Drawing.Point(320,479)
$DisableTasks.Font = 'Segoe UI,10'

$EnableTasks = New-Object System.Windows.Forms.Button
$EnableTasks.Text = "Enable unnecessary tasks"
$EnableTasks.Width = 140
$EnableTasks.Height = 40
$EnableTasks.Location = New-Object System.Drawing.Point(460,479)
$EnableTasks.Font = 'Segoe UI,10'



################ MAINTENANCE ##############

$Label6 = New-Object System.Windows.Forms.Label
$Label6.Text = "                   Maintenance"
$Label6.AutoSize = $true
$Label6.Width = 25
$Label6.Height = 10
$Label6.Location = New-Object System.Drawing.Point(10,410)
$Label6.Font = 'Segoe UI,12,style=Bold'

$RestartComputer = New-Object System.Windows.Forms.Button 
$RestartComputer.Text = "Restart this PC"
$RestartComputer.Width = 140
$RestartComputer.Height = 40
$RestartComputer.Location = New-Object System.Drawing.Point(10, 440)
$RestartComputer.Font = 'Segoe UI,10'

$RestartExplorer = New-Object System.Windows.Forms.Button 
$RestartExplorer.Text = "Restart Windows Explorer"
$RestartExplorer.Width = 140
$RestartExplorer.Height = 40
$RestartExplorer.Location = New-Object System.Drawing.Point(150, 440)
$RestartExplorer.Font = 'Segoe UI,10'


$Label7 = New-Object System.Windows.Forms.Label
$Label7.Text = "CleanWin is FOSS, and shall only be downloaded from https://github.com/pratyakshm/CleanWin"
$Label7.AutoSize = $true
$Label7.Width = 25
$Label7.Height = 10
$Label7.Location = New-Object System.Drawing.Point(10,538)
$Label7.Font = 'Segoe UI,8,style=Monospace' 

$Form.controls.AddRange(@( $Label2, $Label3, $Label3, $Label4, $Label5, $Label6, $Label7, $UninstallAllBloatApps, 
$UninstallAppsSelectively, $InstallChoco ,$ChocInstall, $InstallWSL, 
$UninstallBloatFeatures, $OOShutup10, $DisableDataCollection, $DisableTelemetry, $HostsTelemetry,
$EnableDataCollection, $EnableTelemetry, $FullBandwidth, $ReserveBandwidth, $RestartComputer, $RestartExplorer, $CleanExplorer, $DisableStickyKeys, 
$EnablePrtScrForSnip, $Hide3DObjects, $ShowVerboseStatus, $DisableBlurLockScreen, $ShowSeconds, $UndoCleanExplorer, 
$EnableStickyKeys, $DisablePrtScrForSnip, $Show3DObjects, $HideVerboseStatus,  $EnableBlurLockScreen, $HideSeconds, 
$DisableAutoUpdates, $DisableDefrag, $EnableAutoUpdates, $EnableDefrag, $DisableServices, $EnableServices, $DisableTasks, $EnableTasks))

$CWFolder = "C:\Temp\CleanWin"
If (Test-Path $CWFolder) {
}
Else {
    New-Item -Path "${CWFolder}" -ItemType Directory
}

Start-Transcript -OutputDirectory "${CWFolder}" | Out-Null 

#### BUTTONS CODE ###

#### APPS ####
$UninstallAppsSelectively.Add_Click( {
    Add-Type -AssemblyName PresentationCore, PresentationFramework

    #region Variables
    # ArrayList containing the UWP apps to remove
    $AppxPackages = New-Object -TypeName System.Collections.ArrayList($null)
    
    # List of UWP apps that won't be recommended for removal
    $UncheckedAppxPackages = @(
        # AMD Radeon UWP panel
        "AdvancedMicroDevicesInc*",
    
        # Intel Graphics Control Center
        "AppUp.IntelGraphicsControlPanel",
        "AppUp.IntelGraphicsExperience",
    
        # Calculator
        "Microsoft.WindowsCalculator",
    
        # Debian - WSL
        "TheDebianProject.DebianGNULinux",
    
        # Microsoft Office
        "Microsoft.Office.Desktop.OneNote",
        "Microsoft.Office.Desktop.Word",
        "Microsoft.Office.Desktop",
        "Microsoft.Office.Desktop.Outlook",
        "Microsoft.Office.Desktop.Excel",
        "Microsoft.Office.Desktop.Access",
        "Microsoft.Office.Desktop.PowerPoint",
    
        # Microsoft Store
        "Microsoft.WindowsStore",
    
        # NVIDIA Control Panel
        "NVIDIACorp.NVIDIAControlPanel",
    
        # Photos (and Video Editor)
        "Microsoft.Windows.Photos",
        "Microsoft.Photos.MediaEngineDLC",
    
        # Realtek Audio Console
        "RealtekSemiconductorCorp.RealtekAudioControl",
    
        # Sticky Notes
        "Microsoft.MicrosoftStickyNotes",
    
        # Screen Sketch
        "Microsoft.ScreenSketch",
    
        # Xbox Identity Provider
        "Microsoft.XboxIdentityProvider",
    
        # Xbox TCUI
        "Microsoft.Xbox.TCUI",
    
        # Xbox Speech To Text Overlay
        "Microsoft.XboxSpeechToTextOverlay",
    
        # Xbox Game Bar
        "Microsoft.XboxGamingOverlay",
    
        # Xbox Game Bar Plugin
        "Microsoft.XboxGameOverlay"
    
    )
    
    # UWP apps that won't be shown in the form
    $ExcludedAppxPackages = @(
        # Microsoft Desktop App Installer
        "Microsoft.DesktopAppInstaller",
    
        # Web Media Extensions
        "Microsoft.WebMediaExtensions"
    )
    #endregion Variables
    
    #region XAML Markup
    [xml]$XAML = '
    <Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Name="Window"
        MinHeight="450" MinWidth="400"
        SizeToContent="Width" WindowStartupLocation="CenterScreen"
        TextOptions.TextFormattingMode="Display" SnapsToDevicePixels="True"
        FontFamily="Segoe UI" FontSize="12" ShowInTaskbar="False">
        <Window.Resources>
            <Style TargetType="StackPanel">
                <Setter Property="Orientation" Value="Horizontal"/>
            </Style>
            <Style TargetType="CheckBox">
                <Setter Property="Margin" Value="10, 10, 5, 10"/>
                <Setter Property="IsChecked" Value="True"/>
            </Style>
            <Style TargetType="TextBlock">
                <Setter Property="Margin" Value="5, 10, 10, 10"/>
            </Style>
            <Style TargetType="Button">
                <Setter Property="Margin" Value="20"/>
                <Setter Property="Padding" Value="10"/>
            </Style>
        </Window.Resources>
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <Grid Grid.Row="0">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="1" Orientation="Horizontal">
                    <CheckBox Name="CheckboxRemoveAll" IsChecked="False"/>
                    <TextBlock Name="TextblockRemoveAll"/>
                </StackPanel>
            </Grid>
            <ScrollViewer Name="Scroll" Grid.Row="1"
                HorizontalScrollBarVisibility="Disabled"
                VerticalScrollBarVisibility="Auto">
                <StackPanel Name="PanelContainer" Orientation="Vertical"/>
            </ScrollViewer>
            <Button Name="Button" Grid.Row="2"/>
        </Grid>
    </Window>
    '
    #endregion XAML Markup
    
    $Reader = (New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $XAML)
    $Form = [Windows.Markup.XamlReader]::Load($Reader)
    $XAML.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]") | ForEach-Object -Process {
        Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name) -Scope Global
    }
    
    
    #region Functions
    function Get-CheckboxClicked
    {
        [CmdletBinding()]
        param
        (
            [Parameter(
                Mandatory = $true,
                ValueFromPipeline = $true
            )]
            [ValidateNotNull()]
            $CheckBox
        )
    
        $AppxName = $CheckBox.Parent.Children[1].Text
        if ($CheckBox.IsChecked)
        {
            [void]$AppxPackages.Add($AppxName)
        }
        else
        {
            [void]$AppxPackages.Remove($AppxName)
        }
        if ($AppxPackages.Count -gt 0)
        {
            $Button.IsEnabled = $true
        }
        else
        {
            $Button.IsEnabled = $false
        }
    }
    
    function DeleteButton
    {
        [void]$Window.Close()
        $OFS = "|"
        if ($CheckboxRemoveAll.IsChecked)
        {   
            Write-Host "Removing $AppxPackages..."
            Get-AppxPackage -PackageTypeFilter Bundle -AllUsers | Where-Object -FilterScript {$_.Name -cmatch $AppxPackages} | Remove-AppxPackage -AllUsers
            Write-Host "Done."
        }
        else
        {  
            Write-Host "Removing $AppxPackages..."
            Get-AppxPackage -PackageTypeFilter Bundle | Where-Object -FilterScript {$_.Name -cmatch $AppxPackages} | Remove-AppxPackage
            Write-Host "Done."
        }
        $OFS = " "
    }
    
    function Add-AppxControl
    {
        [CmdletBinding()]
        param
        (
            [Parameter(
                Mandatory = $true,
                ValueFromPipeline = $true
            )]
            [ValidateNotNull()]
            [string]
            $AppxName
        )
    
        $CheckBox = New-Object -TypeName System.Windows.Controls.CheckBox
        $CheckBox.Add_Click({Get-CheckboxClicked -CheckBox $_.Source})
    
        $TextBlock = New-Object -TypeName System.Windows.Controls.TextBlock
        $TextBlock.Text = $AppxName
    
        $StackPanel = New-Object -TypeName System.Windows.Controls.StackPanel
        [void]$StackPanel.Children.Add($CheckBox)
        [void]$StackPanel.Children.Add($TextBlock)
    
        [void]$PanelContainer.Children.Add($StackPanel)
    
        if ($UncheckedAppxPackages.Contains($AppxName))
        {
            $CheckBox.IsChecked = $false
            # Exit function, item is not checked
            return
        }
    
        # If package checked, add to the array list to uninstall
        [void]$AppxPackages.Add($AppxName)
    }
    #endregion Functions
    
    #region Events Handlers
    
    # Window Loaded Event
    $Window.Add_Loaded({
        $OFS = "|"
        (Get-AppxPackage -PackageTypeFilter Bundle -AllUsers | Where-Object -FilterScript {$_.Name -cnotmatch $ExcludedAppxPackages}).Name | ForEach-Object -Process {
            Add-AppxControl -AppxName $_
        }
        $OFS = " "
    
        $TextblockRemoveAll.Text = "Remove for all users"
        $Window.Title = "Uninstall apps selectively"
        $Button.Content = "Uninstall"
    })
    
    # Button Click Event
    $Button.Add_Click({DeleteButton})
    #endregion Events Handlers
    
    if (Get-AppxPackage -PackageTypeFilter Bundle -AllUsers | Where-Object -FilterScript {$_.Name -cnotmatch ($ExcludedAppxPackages -join "|")})
    {
        # Display the dialog box
        $Form.ShowDialog() | Out-Null
    }
    else
    {
        Write-Host "Nothing to display."
    }
})

$UninstallAllBloatApps.Add_Click( { 
$ErrorActionPreference = 'SilentlyContinue'
    Write-Host "Beginning uninstallation of unnecesary apps..."
    $Bloatware = @(
        "Microsoft.549981C3F5F10"
        "Microsoft.BingNews"
        "Microsoft.BingWeather" 
        "Microsoft.GetHelp" 
        "Microsoft.Getstarted" 
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer" 
        "Microsoft.MicrosoftStickyNotes"  
        "Microsoft.MSPaint"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.Office.OneNote"
        "Microsoft.MixedReality.Portal"
        "Microsoft.MicrosoftSolitaireCollection" 
        "Microsoft.NetworkSpeedTest" 
        "Microsoft.News" 
        "Microsoft.Office.Sway" 
        "Microsoft.OneConnect"
        "Microsoft.People" 
        "Microsoft.Print3D" 
        "Microsoft.StorePurchaseApp" 
        "Microsoft.WindowsAlarms"
        "Microsoft.WindowsCommunicationsApps" 
        "Microsoft.WindowsFeedbackHub" 
        "Microsoft.WindowsMaps" 
        "Microsoft.WindowsSoundRecorder" 
        "Microsoft.XboxApp"
        "Microsoft.XboxGamingOverlay"
        "Microsoft.ZuneVideo"

        #Sponsored Windows 10 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
        "*Duolingo-LearnLanguagesforFree*"
        "*PandoraMediaInc*"
        "*CandyCrush*"
        "*BubbleWitch3Saga*"
        "*Wunderlist*"
        "*Flipboard*"
        "*Twitter*"
        "*Facebook*"
        "*Spotify*"
        "*Minecraft*"
        "*Royal Revolt*"
        "*Sway*"
        "*Speed Test*"
        "*Dolby*"
        )
    foreach ($Bloat in $Bloatware) {
    Get-AppxPackage -Name $Bloat| Remove-AppxPackage | Out-Null
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online | Out-Null
    Remove-Item "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Excel.lnk"
    Remove-Item "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Outlook.lnk"
    Remove-Item "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\PowerPoint.lnk"
    Remove-Item "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Word.lnk"
    $Keys = @(
        New-PSDrive HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        #Remove Background Tasks
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
                
        #Windows File
        "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
                
        #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
                
        #Scheduled Tasks to delete
        "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
                
        #Windows Protocol Keys
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
                
        #Windows Share Target
        "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        )
        
    #This writes the output of each key it is removing and also removes the keys listed above.
    ForEach ($Key in $Keys) {
        Remove-Item $Key -Recurse
    }   
    }
    "screen"
    Write-Host "Done."

})

$InstallChoco.Add_Click( {
    Write-Host "Installing Chocolatey package manager..."
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	choco install chocolatey-core.extension -y
	Write-Host "Done."
	Start-Sleep 1
})

$ChocInstall.Add_Click( {
    Get-Content 'ChocInstall.txt' | Foreach-Object {
		$App = $_.Split('=')
		choco install $App -Y
    }
    Write-Host "Done."
})

$InstallNet35.Add_Click( {
    Write-Host "Installing dotNET 3.5..."
    DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart /Quiet
    Write-Host "Done."
})

$InstallWSL.Add_Click( {
    Write-Host "Installing WSL..."
    dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /all /NoRestart /Quiet
	dism.exe /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /All /NoRestart /Quiet
    dism.exe /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V /All /NoRestart	/Quiet
    Write-Host "Done."
})

$UninstallBloatFeatures.Add_Click( {
    Write-Host "Removing unwated features..."
    Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -eq "WorkFolders-Client" } | Disable-WindowsOptionalFeature -Online -NoRestart -WarningAction SilentlyContinue | Out-Null
    Get-WindowsCapability -Online | Where-Object { $_.Name -like "Hello.Face*" } | Remove-WindowsCapability -Online | Out-Null
    Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Remove-WindowsCapability -Online | Out-Null
    Write-Host "Done."
})


###########################
##### E X P L O R E R #####
###########################

$CleanExplorer.Add_Click( {
$ErrorActionPreference = 'SilentlyContinue'

    Write-Host "Cleaning up Windows Explorer..."

    # Sets default explorer view to This PC
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    # Hides 3D objects
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
    $Hide3DObjects1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    $Hide3DObjects2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    If (!(Test-Path $Hide3DObjects1)) {
        New-Item -Path $Hide3DObjects1 -Force | Out-Null
        }
    Set-ItemProperty -Path $Hide3DObjects1 -Name "ThisPCPolicy" -Type String -Value "Hide"
    If (!(Test-Path $Hide3DObjects2)) {
        New-Item -Path $Hide3DObjects2 -Force | Out-Null
        }
    Set-ItemProperty -Path $Hide3DObjects2 -Name "ThisPCPolicy" -Type String -Value "Hide"
        
    # Hide search bar
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    
    # Hide Task view icon
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    
    # Hide Cortana icon
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0

    # Show seconds in taskbar clock
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Type DWord -Value 1
    
    # Hide Meet Now icon from tray
	$Meet1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	$Meet2 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	Set-ItemProperty -Path $Meet1 -Name "HideSCAMeetNow" -Type DWord -Value 1 -ErrorAction SilentlyContinue
	Set-ItemProperty -Path $Meet2 -Name "HideSCAMeetNow" -Type DWord -Value 1

    Write-Host "Done."

})

$UndoCleanExplorer.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'

    Write-Host "Reverting changes..."

    # Enable Sticky keys prompt
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "510"

    # Set Explorer default view to Quick access
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo"

    # Show / Restore 3D objects 
    $Restore3DObjects1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    $Restore3DObjects2 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    $Restore3DObjects3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    If (!(Test-Path $Restore3DObjects1)) {
        New-Item -Path $Restore3DObjects1 | Out-Null
        }
    Remove-ItemProperty -Path $Restore3DObjects2 -Name "ThisPCPolicy"
    Remove-ItemProperty -Path $Restore3DObjects3 -Name "ThisPCPolicy"
    
    # Show search bar icon 
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 2
    
    # Show taskview icon 
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton"
    
    # Show Cortana icon
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 1

    # Hide seconds from taskbar clock
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 1
    
    # Show Meet now icon
	$Meet1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	$Meet2 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	Set-ItemProperty -Path $Meet1 -Name "HideSCAMeetNow" -Type DWord -Value 0
    Set-ItemProperty -Path $Meet2 -Name "HideSCAMeetNow" -Type DWord -Value 0

    # Restart explorer.exe to reflect changes immeditately and then provide 2 seconds of breathing time
    Stop-Process -ProcessName explorer
    Start-Sleep 2

    Write-Host "Done."

})

$ShowVerboseStatus.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Type DWord -Value 1
    Write-Host "Done."
})

$HideVerboseStatus.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Type DWord -Value 0
    Write-Host "Done."
})

$DisableBlurLockScreen.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "DisableAcrylicBackgroundOnLogon" -Type DWord -Value 1
    Write-Host "Done." 
})

$EnableBlurLockScreen.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "DisableAcrylicBackgroundOnLogon" -Type DWord -Value 0
    Write-Host "Done." 
})


$ShowSeconds.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Type DWord -Value 1
    Write-Host "Done."
})

$HideSeconds.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Type DWord -Value 0
    Write-Host "Done."
})

$Hide3DObjects.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    $Hide3DObjects1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    $Hide3DObjects2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    $Hide3DObjects3 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    If (!(Test-Path $Hide3DObjects1)) {
        New-Item -Path $Hide3DObjects1 -Force | Out-Null
        }
    Set-ItemProperty -Path $Hide3DObjects1 -Name "ThisPCPolicy" -Type String -Value "Hide"
    If (!(Test-Path $Hide3DObjects2)) {
        New-Item -Path $Hide3DObjects2 -Force | Out-Null
        }
    Set-ItemProperty -Path $Hide3DObjects2 -Name "ThisPCPolicy" -Type String -Value "Hide"
    Remove-Item -Path $Hide3DObjects3 -Recurse
    Write-Host "Done."
})

$Show3DObjects.Add_Click( {
    $Restore3DObjects1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    $Restore3DObjects2 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    $Restore3DObjects3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag"
    If (!(Test-Path $Restore3DObjects1)) {
        New-Item -Path $Restore3DObjects1 | Out-Null
        }
    Remove-ItemProperty -Path $Restore3DObjects2 -Name "ThisPCPolicy"
    Remove-ItemProperty -Path $Restore3DObjects3 -Name "ThisPCPolicy"
    Write-Host "Done."
})

$EnablePrtScrForSnip.Add_Click( {
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "PrintScreenKeyForSnippingEnabled" -Type DWord -Value 1
    Write-Host "Done."
})

$DisablePrtScrForSnip.Add_Click( {
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "PrintScreenKeyForSnippingEnabled" -Type DWord -Value 0
    Write-Host "Done."
})

$DisableStickyKeys.Add_Click( {
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
    Write-Host "Done."
})

$EnableStickyKeys.Add_Click( {
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "510"
    Write-Host "Done."
})


#################
#### PRIVACY ####
#################
$DisableDataCollection.Add_Click( { 
$ErrorActionPreference = 'SilentlyContinue'

    Write-Host "Turning off data collection..."
    
	# Disable suggestions and bloatware auto-install
	$Suggestions1 = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
	$Suggestions2 = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
	Set-ItemProperty -Path $Suggestions1 -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path $Suggestions1 -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path $Suggestions1 -Name "SoftLandingEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path $Suggestions1 -Name "SubscribedContent" -Type DWord -Value 0

	# Disable tailored experiences
	$CloudContent = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
	If (!(Test-Path $CloudContent )) {
		New-Item $CloudContent -Force | Out-Null
		}
	Set-ItemProperty -Path $CloudContent -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1

	# Disable scheduled tasks
	Get-ScheduledTask Consolidator | Disable-ScheduledTask | Out-Null
	Get-ScheduledTask DmClient | Disable-ScheduledTask | Out-Null
	Get-ScheduledTask DmClientOnScenarioDownload | Disable-ScheduledTask | Out-Null
	Get-ScheduledTask ProgramDataUpdater | Disable-ScheduledTask | Out-Null
	Get-ScheduledTask QueueReporting | Disable-ScheduledTask | Out-Null
	Get-ScheduledTask UsbCeip | Disable-ScheduledTask | Out-Null

	# Disable telemetry
	$DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
	$DataCollection2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
	$DataCollection3 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
	Set-ItemProperty -Path $DataCollection1 -Name "AllowTelemetry" -Type DWord -Value 0
	Set-ItemProperty -Path $DataCollection2 -Name "AllowTelemetry" -Type DWord -Value 0
	Set-ItemProperty -Path $DataCollection3 -Name "AllowTelemetry" -Type DWord -Value 0

	# Stop and disable telemetry services
	Stop-Service DiagTrack | Set-Service -StartupType Disabled
	Stop-Service dmwappushservice | Set-Service -StartupType Disabled

    $ActivityFeed = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
    Set-ItemProperty -Path $ActivityFeed -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path $ActivityFeed -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path $ActivityFeed -Name "UploadUserActivities" -Type DWord -Value 0	
    
    # Disable Advertising ID
    $AdvertisingID = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
    If (!(Test-Path $AdvertisingID)) {
        New-Item -Path $AdvertisingID | Out-Null
    }
    Set-ItemProperty -Path $AdvertisingID -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    
    # Disable Feedback
    $Feedback1 = "HKCU:\SOFTWARE\Microsoft\Siuf\Rules"
    $Feedback2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $Feedback3 = "Microsoft\Windows\Feedback\Siuf\DmClient"
    $Feedback4 = "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
    If (!(Test-Path $Feedback1)) {
        New-Item -Path $Feedback1 -Force | Out-Null
    }
    Set-ItemProperty -Path $Feedback1 -Name "NumberOfSIUFInPeriod" -Type DWord -Value 1
    If (!(Test-Path $Feedback2)) {
        New-Item -Path $Feedback2 -Force | Out-Null
    }
    Set-ItemProperty -Path $Feedback2 -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName $Feedback3 -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName $Feedback4 -ErrorAction SilentlyContinue | Out-Null
    
    # Disable Background apps
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach-Object {
        Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
        Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
    }
    
    # Disable Location Tracking
    $Location1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
    $Location2 = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    If (!(Test-Path $Location1)) {
        New-Item -Path $Location1 -Force | Out-Null
    }
    Set-ItemProperty -Path $Location1 -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path $Location2 -Name "SensorPermissionState" -Type DWord -Value 0
    
    # Disable language list access for relevant content
    $Language = "HKCU:\Control Panel\International\User Profile"
    If (!(Test-Path $Language)) {
        New-Item -Path $Language | Out-Null
    }
    Set-ItemProperty -Path $Language -Name "HttpAcceptLanguageOptOut " -Type DWord -Value 1
    
    # Disable automatic Maps updates
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    
    # Disable Speech Recognition
    $Speech = "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy"
    If (!(Test-Path $Speech)) {
        New-Item -Path $Speech | Out-Null
    }
    Set-ItemProperty -Path $Speech -Name "HasAccepted" -Type DWord -Value 0
    
    # Disable suggestions and bloatware auto-install
    $Suggestions1 = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    $Suggestions2 = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    Set-ItemProperty -Path $Suggestions1 -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path $Suggestions1 -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path $Suggestions2 -Name "ShowSyncProviderNotifications" -Type DWord -Value 0
    Set-ItemProperty -Path $Suggestions1 -Name "SoftLandingEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path $Suggestions1 -Name "SubscribedContent" -Type DWord -Value 0
    
    Write-Host "Done."
})


$EnableDataCollection.Add_Click( { 
    $ErrorActionPreference = 'SilentlyContinue'

    Write-Host "Turning on data collection..."

	# Enable advertising ID
    $Advertising = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
    Remove-ItemProperty -Path $Advertising -Name "DisabledByGroupPolicy"

	# Enable activity history
    $ActivityHistory = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
    Set-ItemProperty -Path $ActivityHistory -Name "EnableActivityFeed" -Type DWord -Value 1
    Set-ItemProperty -Path $ActivityHistory -Name "PublishUserActivities" -Type DWord -Value 1
    Set-ItemProperty -Path $ActivityHistory -Name "UploadUserActivities" -Type DWord -Value 1
	
	# Enable feedback
    $Feedback = "HKCU:\SOFTWARE\Microsoft\Siuf\Rules"
    If (!(Test-Path $Feedback )) {
        New-Item $Feedback -Force | Out-Null
    }
    Remove-ItemProperty -Path $Feedback -Name "NumberOfSIUFInPeriod"

	# Enable language list
    $LanguageList = "HKCU:\Control Panel\International\User Profile"
    If (!(Test-Path $LanguageList)) {
        New-Item -Path $LanguageList | Out-Null
        }
    Set-ItemProperty -Path $LanguageList  -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 0
        
	# Enable location tracking
    $Location1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
    $Location2 = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    If (!(Test-Path $Location1)) {
        New-Item -Path $Location1 -Force | Out-Null
    }
    Set-ItemProperty -Path $Location1 -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path $Location2 -Name "SensorPermissionState" -Type DWord -Value 1
        
	# Disable Maps updates
    Remove-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled"

	# Enable suggestions and bloatware auto-install
    $Suggestions1 = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    $Suggestions2 = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    Remove-ItemProperty -Path $Suggestions1 -Name "SilentInstalledAppsEnabled"
    Remove-ItemProperty -Path $Suggestions1 -Name "SystemPaneSuggestionsEnabled"
    Remove-ItemProperty -Path $Suggestions2 -Name "ShowSyncProviderNotifications"
    Remove-ItemProperty -Path $Suggestions1 -Name "SoftLandingEnabled"
    Remove-ItemProperty -Path $Suggestions1 -Name "SubscribedContent"

	# Enable speech recognition
    $Speech = "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy"
    If (!(Test-Path $Speech)) {
        New-Item -Path $Speech | Out-Null
    }
    Set-ItemProperty -Path $Speech -Name "HasAccepted" -Type DWord -Value 1
	
	# Enable Tailored Experiences
    $TailoredExp1 = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    $TailoredExp2 = "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting"
    $TailoredExp3 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    Remove-ItemProperty -Path $TailoredExp1 -Name "DisableTailoredExperiencesWithDiagnosticData"
    Remove-ItemProperty -Path $TailoredExp2 -Name "Disabled"
    Remove-ItemProperty -Path $TailoredExp3 -Name "DoNotShowFeedbackNotifications"
	
	# Enable telemetry
    $Telemetry1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $Telemetry2 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $Telemetry3 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    Set-ItemProperty -Path $Telemetry1  -Name "AllowTelemetry" -Type DWord -Value 3
    Set-ItemProperty -Path $Telemetry2 -Name "AllowTelemetry" -Type DWord -Value 3
    Set-ItemProperty -Path $Telemetry3 -Name "AllowTelemetry" -Type DWord -Value 3
	
	# Start telemetry services
    Start-Service DiagTrack | Set-Service -StartupType Automatic
    Start-Service dmwappushservice | Set-Service -StartupType Automatic
	
	# Enable tasks
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    
    Write-Host "Data collection turned on."
})

$DisableTelemetry.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    $Telemetry = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    Set-ItemProperty -Path $Telemetry -Name "AllowCommericalDataPipeline" -Type DWord -Value 1
    Set-ItemProperty -Path $Telemetry -Name "AllowDeviceNameInTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path $Telemetry -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path $Telemetry -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Set-ItemProperty -Path $Telemetry -Name "LimitEnhancedDiagnosticDataWindowsAnalytics" -Type DWord -Value 0
    Write-Host "Done."
})

$EnableTelemetry.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Write-Host "Turning on telemetry..."
    $Telemetry = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    Remove-ItemProperty -Path $Telemetry -Name "AllowTelemetry"
    Remove-ItemProperty -Path $Telemetry -Name "AllowCommericalDataPipeline"
    Remove-ItemProperty -Path $Telemetry -Name "DoNotShowFeedbackNotifications"
    Remove-ItemProperty -Path $Telemetry -Name "LimitEnhancedDiagnosticDataWindowsAnalytics"
    Remove-ItemProperty -Path $Telemetry -Name "AllowDeviceNameInTelemetry"
    Write-Host "Done."
})

$OOShutup10.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
	Import-Module BitsTransfer
	Start-BitsTransfer -Source "https://raw.githubusercontent.com/pratyakshm/CleanWin/main/files/ooshutup10.cfg" -Destination ooshutup10.cfg
	Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup10.cfg /quiet
    Remove-Item ooshutup10.cfg
    Remove-Item  OOSU10.exe
    Write-Host "Done."
    })

$HostsTelemetry.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/pratyakshm/CleanWin/main/files/hosts-telemetry.bat" -Destination hoststelemetry.bat
    ./hoststelemetry.bat /quiet
    Remove-Item hoststelemetry.bat
    Write-Host "Done."
})

$FullBandwidth.Add_Click( {
    $ErrorActionPreference = 'SilentlyContinue'
    $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
    New-Item -Path $Bandwidth -ItemType Directory -Force
    Set-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit" -Type DWord -Value 0
    Write-Host "Done."
})

$ReserveBandwidth.Add_Click({
    $ErrorActionPreference = 'SilentlyContinue'
    $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
    Remove-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit"
    Write-Host "Done."
})


############################################
#####  T A S K S & S E R V I C E S ########
###########################################

$DisableAutoUpdates.Add_Click( {
$ErrorActionPreference = 'SilentlyContinue'
    $Update1 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    $Update2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
        If (!(Test-Path $Update1)) {
          New-Item -Path $Update1 | Out-Null
          New-Item -Path $Update2 | Out-Null
          }
    Set-ItemProperty -Path $Update2 -Name NoAutoUpdate -Type DWord -Value 1
    Write-Host "Done."
})

$EnableAutoUpdates.Add_Click( {
$ErrorActionPreference = 'SilentlyContinue'
    Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Recurse -ErrorAction SilentlyContinue 
    Write-Host "Done."
})

$DisableDefrag.Add_Click( {
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
    Write-Host "Done."
})

$EnableDefrag.Add_Click( {
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
    Write-Host "Done."
})

$DisableServices.Add_Click( {
	Set-Service RetailDemo -StartupType Disabled -ErrorAction SilentlyContinue
	Set-Service "diagnosticshub.standardcollector.service" -StartupType Disabled -ErrorAction SilentlyContinue
	Set-Service MapsBroker  -StartupType Disabled -ErrorAction SilentlyContinue
	Set-Service NetTcpPortSharing  -StartupType Disabled -ErrorAction SilentlyContinue
	Set-Service RemoteAccess -StartupType Disabled -ErrorAction SilentlyContinue 
	Set-Service RemoteRegistry -StartupType Disabled -ErrorAction SilentlyContinue 
	Set-Service SharedAccess -StartupType Disabled -ErrorAction SilentlyContinue 
	Set-Service TrkWks -StartupType Disabled -ErrorAction SilentlyContinue 
	Write-Host "Done."
})

$EnableServices.Add_Click( {
	Set-Service RetailDemo -StartupType Automatic -ErrorAction SilentlyContinue
	Set-Service "diagnosticshub.standardcollector.service" -StartupType Automatic -ErrorAction SilentlyContinue
	Set-Service MapsBroker  -StartupType Automatic -ErrorAction SilentlyContinue
	Set-Service NetTcpPortSharing  -StartupType Automatic -ErrorAction SilentlyContinue
	Set-Service RemoteAccess -StartupType Automatic -ErrorAction SilentlyContinue 
	Set-Service RemoteRegistry -StartupType Automatic -ErrorAction SilentlyContinue 
	Set-Service SharedAccess -StartupType Automatic -ErrorAction SilentlyContinue 
    Set-Service TrkWks -StartupType Automatic -ErrorAction SilentlyContinue 
    Write-Host "Done."
})

$DisableTasks.Add_Click( {
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
	Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-Host "Done."
})

$EnableTasks.Add_Click( {
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
	Enable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
	Enable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
	Enable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
	Enable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
	Enable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
	Enable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
	Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-Host "Done."
})

##############################
##### MAINTENANCE ########
##############################


$RestartComputer.Add_Click( {
    Restart-Computer -Force
})

$RestartExplorer.Add_Click( {
    Stop-Process -ProcessName explorer
})

[void]$Form.ShowDialog()