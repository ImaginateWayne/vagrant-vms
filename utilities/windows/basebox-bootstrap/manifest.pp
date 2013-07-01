file { $pkg:
  ensure => present,
  name   => 'C:\Temp\Git-1.8.1.2-preview20130201.exe',
  source => 'puppet:///puppetfs/Git-1.8.1.2-preview20130201.exe',
  mode   => '0755',
  before => Exec[$pkg]
}

exec { $pkg:
  creates   => 'C:\Program Files (x86)\Git\bin',
  command   => 'C:\Windows\sysnative\cmd.exe /k "C:\Temp\Git-1.8.1.2-preview20130201.exe /SP- /NORESTART /VERYSILENT /SUPPRESSMSGBOXES /SAVEINF="C:\Temp\git-settings.txt" /LOG="C:\Temp\git-installer.log"',
  logoutput => true,
  timeout   => 900
}