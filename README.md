# windows_uac Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/windows_uac.svg)](https://supermarket.chef.io/cookbooks/windows_uac) [![Build status](https://ci.appveyor.com/api/projects/status/6sntpwminbxsljmw/branch/master?svg=true)](https://ci.appveyor.com/project/ChefWindowsCookbooks/windows-uac/branch/master)

The windows_uac resource configures UAC on Windows hosts by setting registry keys at 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'

## DEPRECATED

This resource now ships in Chef Infra Client 15.0 and later. No further development will take place in this repository, but feel free to continue to use it for earlier Chef releases.

## Requirements

### Platforms

- Windows 8, 8.1, 10
- Windows Server 2012 (R1, R2)
- Windows Server 2016
- Windows Server 2019

### Chef

- Chef 13.9+

## Resources

### windows_uac

#### Actions

- `:configure` - configure UAC rules

#### properties

- `enable_uac`: Enable or disable UAC Admin Approval Mode. If this is changed a system restart is required. Sets HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA. default: true
- `require_signed_binaries`: Only elevate executables that are signed and validated. Sets HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA\ValidateAdminCodeSignatures. default: false
- `prompt_on_secure_desktop`: Switch to the secure desktop when prompting for elevation. Sets HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA\PromptOnSecureDesktop. default: true
- `detect_installers` Detect application installations and prompt for elevation. Sets HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA\EnableInstallerDetection. default: not set
- `consent_behavior_admins`: Behavior of the elevation prompt for administrators in Admin Approval Mode. Sets HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA\ConsentPromptBehaviorAdmin. Options: :no_prompt, :secure_prompt_for_creds, :secure_prompt_for_consent, :prompt_for_creds, :prompt_for_consent, :prompt_for_consent_non_windows_binaries. default: :prompt_for_consent_non_windows_binaries
- `consent_behavior_users`: Behavior of the elevation prompt for standard users. Sets HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA\ConsentPromptBehaviorUser. Options: :auto_deny, :secure_prompt_for_creds, :prompt_for_creds. default: :prompt_for_creds

#### Examples

```ruby
  windows_uac 'Disable UAC prompts for the admin' do
    enable_uac true
    prompt_on_secure_desktop false
    consent_behavior_admins :no_prompt
  end
```

```ruby
  windows_uac 'Disable UAC entirely' do
    enable_uac false
  end
```

## License & Authors

- Author:: Tim Smith (tsmith@chef.io)

```text
Copyright:: 2019 Chef Software, Inc.


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
