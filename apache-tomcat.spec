Name: apache-tomcat
Version: 7.0.65
Release: 1
Summary: Open source software implementation of the Java Servlet and JavaServer Pages technologies.
Group: Productivity/Networking/Web/Servers
License: Apache Software License.
Url: http://tomcat.apache.org
Source: %{name}-%{version}-src.tar.gz

BuildRoot: %{_tmppath}/%{name}-%{version}-build
BuildRequires: ant
BuildRequires: java-1.6.0-openjdk
BuildRequires: java-1.7.0-openjdk
Requires: java
BuildArch: x86_64

%description
Apache Tomcat is an open source software implementation of the Java Servlet and JavaServer Pages technologies. The Java Servlet and JavaServer Pages specifications are developed under the Java Community Process.

%package manager
Summary: The management web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name} = %{version}-%{release}
BuildArch: noarch

%description manager
The management web application of Apache Tomcat.

%package ROOT
Summary: The ROOT web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}-%{version}-%{release}
BuildArch: noarch

%description ROOT
The ROOT web application of Apache Tomcat.

%package docs
Summary: The docs web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}-%{version}-%{release}
BuildArch: noarch

%description docs
The docs web application of Apache Tomcat.

%package examples
Summary: The examples web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}-%{version}-%{release}
BuildArch: noarch

%description examples
The examples web application of Apache Tomcat.

%package host-manager
Summary: The host-manager web application of Apache Tomcat.
Group: System Environmnet/Applications
Requires: %{name}-%{version}-%{release}
BuildArch: noarch

%description host-manager
The host-manager web application of Apache Tomcat.

%prep

%setup -q -n %{name}-%{version}-src
# This tells ant to install software in a specific directory.
cat << EOF >> build.properties
base.path=%{buildroot}/opt/apache-tomcat
java.7.home=/usr/lib/jvm/java-_1.7.0_openjdk
EOF

%build

rpm -qa | grep java

update-alternatives --list
update-alternatives --set java /usr/lib/jvm/jre-1.6.0-openjdk.x86_64/bin/java
update-alternatives --display java_sdk_openjdk
update-alternatives --set java_sdk_openjdk /usr/lib/jvm/java-1.6.0-openjdk.x86_64 
update-alternatives --display javac
update-alternatives --set javac /usr/lib/jvm/java-1.6.0-openjdk.x86_64/bin/javac
update-alternataives --display jre-openjdk
update-alternatives --set jre_openjdk /usr/lib/jvm/java-1.6.0-openjdk.x86_64/jre/
update-alternatives --list
ant

%install
rm -Rf %{buildroot}
mkdir -p %{buildroot}/opt/%{name}
mkdir -p %{buildroot}/opt/%{name}/pid
mkdir -p %{buildroot}/opt/%{name}/webapps
mkdir -p %{buildroot}/etc/init.d/
mkdir -p %{buildroot}/var/run/%{name}
%{__cp} -Rip ./output/build/{bin,conf,lib,logs,temp,webapps} %{buildroot}/opt/%{name}
%{__cp} %{_sourcedir}/%{name}-initscript %{buildroot}/etc/init.d/%{name}

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
case "$1" in
  1)
    # This is an initial install.
    chkconfig --add %{name}
  ;;
  2)
    # This is an upgrade.
    # First delete the registered service.
    chkconfig --del %{name}
    # Then add the registered service. In case run levels changed in the init script, the service will be correctly re-added.
    chkconfig --add %{name}
  ;;
esac

%preun
case "$1" in
  0)
    # This is an un-installation.
    service %{name} stop
    chkconfig --del %{name}
  ;;
  1)
    # This is an upgrade.
    # Do nothing.
    :
  ;;
esac

%files
%defattr(-,tomcat,tomcat,-)
%dir /opt/%{name}
%config /opt/%{name}/conf/*
/opt/%{name}/bin
/opt/%{name}/lib
/opt/%{name}/logs
/opt/%{name}/temp
/opt/%{name}/pid
%dir /opt/%{name}/webapps
/var/run/%{name}
%attr(0755,root,root) /etc/init.d/%{name}

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
