Summary: FiftyOneDegrees Pattern V3
Name: FiftyOneDegrees-PatternV3
Version: 0.01
Release: @RELEASE@
Source: %{name}-%{version}.tar.gz
License: copyright CDK
Group: Applications/System
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
AutoReqProv: yes

%description
FiftyOneDegrees PatternWrapper V3

%prep

%setup

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p ${RPM_BUILD_ROOT}/opt/51Degrees/lib/FiftyOneDegrees
cp lib/FiftyOneDegrees/PatternV3.pm $RPM_BUILD_ROOT/opt/51Degrees/lib/FiftyOneDegrees

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
/opt/51Degrees/lib/FiftyOneDegrees/PatternV3.pm
