# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       sailsecure
Summary:    TextSecure client for sailfish os
Version:    0.3.0
Release:    1
Group:      Applications/Multimedia
License:    GPL
Requires:   sailfishsilica-qt5
BuildRequires:  pkgconfig(sailfishapp)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  desktop-file-utils

%description
Signal client for SailfishOS


%prep
# >> setup
#%setup -q -n example-app-%{version}
rm -rf vendor
# << setup

%build
# >> build pre
GOPATH=%(pwd)/../../../..
GOROOT=~/go
export GOPATH GOROOT
cd %(pwd)
if [ $DEB_HOST_ARCH == "armel" ]
then
~/go/bin/linux_arm/go build -v -ldflags "-s" -o %{name} 
else
~/go/bin/go build -v -ldflags "-s" -o %{name}
fi
# << build pre

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
install -d %{buildroot}%{_bindir}
install -p -m 0755 %(pwd)/%{name} %{buildroot}%{_bindir}/%{name}
install -d %{buildroot}%{_datadir}/applications
install -d %{buildroot}%{_datadir}/%{name}/qml
install -d %{buildroot}%{_datadir}/lipstick/notificationcategories
cp -r qml/* %{buildroot}%{_datadir}/%{name}/qml 
install -d %{buildroot}%{_datadir}/icons/hicolor/86x86/apps
install -m 0444 -t %{buildroot}%{_datadir}/icons/hicolor/86x86/apps qml/%{name}.png
install -p %(pwd)/sailsecure.desktop %{buildroot}%{_datadir}/applications/%{name}.desktop
install -p %(pwd)/sailsecure.message.conf %{buildroot}%{_datadir}/lipstick/notificationcategories/%{name}.message.conf
# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_datadir}/applications/%{name}.desktop
%{_datadir}/%{name}/qml
#%{_datadir}/%{name}/qml/i18n
%{_datadir}/icons/hicolor/86x86/apps
%{_datadir}/lipstick/notificationcategories/%{name}.message.conf
%{_bindir}
# >> files
# << files
