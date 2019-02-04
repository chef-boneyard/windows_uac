#
# Cookbook Name:: test
# Recipe:: default

windows_uac 'Configure UAC' do
  enable_uac true
  prompt_on_secure_desktop false
  consent_behavior_admins :no_prompt
end
