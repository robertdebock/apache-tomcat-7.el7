Name: apache-tomcat
Version: 7.0.88
Release: 1.el7
Summary: Open source software implementation of the Java Servlet and JavaServer Pages technologies.
Group: Productivity/Networking/Web/Servers
License: Apache Software License.
Url: http://tomcat.apache.org
Source: http://apache.xl-mirror.nl/tomcat/tomcat-7/v%{version}/src/%{name}-%{version}-src.tar.gz

BuildRoot: %{_tmppath}/%{name}-%{version}-build
BuildRequires: ant
BuildRequires: java-1.7.0-openjdk java-1.7.0-openjdk-devel
Requires: java
BuildArch: x86_64

%description
Apache Tomcat is an open source software implementation of the Java Servlet and JavaServer Pages technologies. The Java Servlet and JavaServer Pages specifications are developed under the Java Community Process.

%package manager
Summary: The management web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}(x86-64) = %{version}-%{release}
BuildArch: noarch

%description manager
The management web application of Apache Tomcat.

%package ROOT
Summary: The ROOT web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}(x86-64) = %{version}-%{release}
BuildArch: noarch

%description ROOT
The ROOT web application of Apache Tomcat.

%package docs
Summary: The docs web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}(x86-64) = %{version}-%{release}
BuildArch: noarch

%description docs
The docs web application of Apache Tomcat.

%package examples
Summary: The examples web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}(x86-64) = %{version}-%{release}
BuildArch: noarch

%description examples
The examples web application of Apache Tomcat.

%package host-manager
Summary: The host-manager web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}(x86-64) = %{version}-%{release}
BuildArch: noarch

%description host-manager
The host-manager web application of Apache Tomcat.

%prep

%setup -n %{name}-%{version}
# Find the path for java home:
java7home=$(find /usr/lib/jvm -type d -name 'java-1.7.0-openjdk*')

cat << EOF >> build.properties
# This tells ant to install software in a specific directory.
base.path=%{buildroot}/opt/%{name}
# Building happens with java 1.6, but to make websockets work, java 1.7 needs to be available.
java.7.home=${java7home}
EOF

%build
update-alternatives --set javac /usr/lib/jvm/java-1.6.0-openjdk.x86_64/bin/javac
ant

%install
rm -Rf %{buildroot}
mkdir -p %{buildroot}/opt/%{name}
mkdir -p %{buildroot}/opt/%{name}/pid
mkdir -p %{buildroot}/opt/%{name}/webapps/
mkdir -p %{buildroot}/etc/systemd/system/
mkdir -p %{buildroot}/var/run/%{name}
%{__cp} -Rip ./output/build/{bin,conf,lib,logs,temp,webapps} %{buildroot}/opt/%{name}
%{__cp} %{_sourcedir}/%{name}.service %{buildroot}/etc/systemd/system/

%clean
rm -rf %{buildroot}

%pre
case "$1" in
  1)
    # This is an initial installation.
    getent group %{name} > /dev/null || groupadd -r %{name}
    getent passwd %{name} > /dev/null || useradd -r -g %{name} %{name}
  ;;
  2)
    # This is an upgrade.
    # Do nothing.
    :
  ;;
esac

%post
%systemd_post %{name}.service

%preun
%systemd_preun %{name}.service

%postun
%systemd_postun_with_restart {name}.service 

%files
%defattr(-,%{name},%{name},-)
%dir /opt/%{name}
%config /opt/%{name}/conf/*
/opt/%{name}/bin
/opt/%{name}/lib
/opt/%{name}/logs
/opt/%{name}/temp
/opt/%{name}/pid
%dir /opt/%{name}/webapps
/var/run/%{name}
%attr(0644,root,root) /etc/systemd/system/%{name}.service

%files manager
/opt/%{name}/webapps/manager

%files ROOT
/opt/%{name}/webapps/ROOT

%files docs
/opt/%{name}/webapps/docs

%files examples
/opt/%{name}/webapps/examples

%files host-manager
/opt/%{name}/webapps/host-manager

%changelog
* Tue Dec 8 2015 - robert (at) meinit.nl
- Removed debugging options.
* Thu Oct 29 2015 - robert (at) meinit.nl
- Cleaned up the RPM a bit.
* Fri Oct 23 2015 - robert (at) meinit.nl
- Changed apache-tomcat for %{name} and changed %pre logic.
* Thu Oct 22 2015 - robert (at) meinit.nl
- Importing to github and attempting to build in Travis CI
- Updating to 7.0.65
* Fri Aug 19 2011 - robert (at) meinit.nl
- Updated to apache tomcat 7.0.20
- Split (example) applications into their own RPM.
* Mon Jul 4 2011 - robert (at) meinit.nl
- Initial release.
