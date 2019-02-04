# windows_uac Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/windows_uac.svg)](https://supermarket.chef.io/cookbooks/windows_uac) [![Build status](https://ci.appveyor.com/api/projects/status/39o3tnenw2njhw1b/branch/master?svg=true)](https://ci.appveyor.com/project/ChefWindowsCookbooks/windows-firewall/branch/master)

The windows_uac resource configures UAC on Windows hosts by setting registry keys at 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'

## Requirements

### Platforms

- Windows 8, 8.1, 10
- Windows Server 2012 (R1, R2)
- Windows Server 2016
- Windows Server 2019

### Chef

- Chef 13.9+

## Resources

### windows_windows_uacuac_rule

#### Actions

- `:configure` - configure UAC rules

#### properties

- `enable_uac`: default: true
- `require_signed_binaries`: default: false
- `prompt_on_secure_desktop`: default: true
- `detect_installers` default: not set
- `consent_behavior_admins`: :no_prompt, :secure_prompt_for_creds, :secure_prompt_for_consent, :prompt_for_creds, :prompt_for_consent, :prompt_for_consent_non_windows_binaries. default: :prompt_for_consent_non_windows_binaries
- `consent_behavior_users`: :auto_deny, :secure_prompt_for_creds, :prompt_for_creds. default: :prompt_for_creds

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
