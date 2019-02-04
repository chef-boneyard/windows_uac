#
# Cookbook Name:: windows_uac
# Resource:: default
#
# Author:: Tim Smit (tsmith@chef.io)
# Copyright:: 2019, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

description 'The windows_uac resource configures UAC on Windows hosts by setting registry keys at \'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\''

# https://docs.microsoft.com/en-us/windows/security/identity-protection/user-account-control/user-account-control-group-policy-and-registry-key-settings#user-account-control-virtualize-file-and-registry-write-failures-to-per-user-locations
property :enable_uac, [TrueClass, FalseClass],
         description: '',
         default: true # EnableLUA

property :require_signed_binaries, [TrueClass, FalseClass],
         description: '',
         default: false # ValidateAdminCodeSignatures

property :prompt_on_secure_desktop, [TrueClass, FalseClass],
         description: '',
         default: true # PromptOnSecureDesktop

property :consent_behavior_admins, Symbol,
         description: '',
         equal_to: [:no_prompt, :secure_prompt_for_creds, :secure_prompt_for_consent, :prompt_for_creds, :prompt_for_consent, :prompt_for_consent_non_windows_binaries],
         default: :prompt_for_consent_non_windows_binaries # ConsentPromptBehaviorAdmin

property :consent_behavior_users, Symbol,
         description: '',
         equal_to: [:auto_deny, :secure_prompt_for_creds, :prompt_for_creds],
         default: :prompt_for_creds # ConsentPromptBehaviorUser

property :detect_installers, [TrueClass, FalseClass],
         description: '' # EnableInstallerDetection

action :configure do
  description 'Configures UAC by setting registry keys at \'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\''

  registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
    values [{ name: 'EnableLUA', type: :dword, data: bool_to_reg(new_resource.enable_uac) },
            { name: 'ValidateAdminCodeSignatures', type: :dword, data: bool_to_reg(new_resource.require_signed_binaries) },
            { name: 'PromptOnSecureDesktop', type: :dword, data: bool_to_reg(new_resource.prompt_on_secure_desktop) },
            { name: 'ConsentPromptBehaviorAdmin', type: :dword, data: consent_behavior_admins_symbol_to_reg(new_resource.consent_behavior_admins) },
            { name: 'ConsentPromptBehaviorUser', type: :dword, data: consent_behavior_users_symbol_to_reg(new_resource.consent_behavior_users) },
            { name: 'EnableInstallerDetection', type: :dword, data: bool_to_reg(new_resource.detect_installers) },
         ]
    action :create
  end
end

action_class do
  def bool_to_reg(bool)
    bool ? 1 : 0
  end

  def consent_behavior_admins_symbol_to_reg(sym)
    [:no_prompt, :secure_prompt_for_creds, :secure_prompt_for_consent, :prompt_for_creds, :prompt_for_consent, :prompt_for_consent_non_windows_binaries].index(sym)
  end

  def consent_behavior_users_symbol_to_reg(sym)
    [:auto_deny, :secure_prompt_for_creds, :prompt_for_creds].index(sym)
  end
end
