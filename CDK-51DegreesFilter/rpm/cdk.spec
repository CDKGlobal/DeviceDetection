Summary: CDK 51Degrees Filter
Name: CDK-51DegreesFilter
Version: 0.01
Release: @RELEASE@
Source: %{name}-%{version}.tar.gz
License: copyright CDK
Group: Applications/System
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
AutoReqProv: yes

%description
CDK 51Degrees Filter

%prep

%setup

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p ${RPM_BUILD_ROOT}/opt/51Degrees/lib/CDK
cp lib/CDK/51DegreesFilter.pm $RPM_BUILD_ROOT/opt/51Degrees/lib/CDK


%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
/opt/51Degrees/lib/CDK/51DegreesFilter.pm
