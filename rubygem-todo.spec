# Generated from pkg/todo-0.0.1.gem by gem2rpm -*- rpm-spec -*-
%define rbname todo
%define version 0.0.1
%define release 1

Summary: Command-line to do application from Building Awesome Command-Line Applications in Ruby
Name: ruby-gems-%{rbname}

Version: %{version}
Release: %{release}
Group: Development/Ruby
License: Distributable
URL: http://blog.cynthiakiser.com
Source0: %{rbname}-%{version}.gem
# Make sure the spec template is included in the SRPM
Source1: ruby-gems-%{rbname}.spec.in
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Requires: ruby [""]
Requires: ruby-gems >= 1.8.24
Requires: ruby-gems-rake 
Requires: ruby-gems-rdoc 
Requires: ruby-gems-aruba 
Requires: ruby-gems-gli = 2.4.1
BuildRequires: ruby [""]
BuildRequires: ruby-gems >= 1.8.24
BuildArch: noarch
Provides: ruby(Todo) = %{version}

%define gemdir /Users/cnk/.rvm/gems/ruby-1.9.3-p194@command-line-book
%define gembuilddir %{buildroot}%{gemdir}

%description
Command line suite to create, list, and mark as done to do items in one or
more to do lists.


%prep
%setup -T -c

%build

%install
%{__rm} -rf %{buildroot}
mkdir -p %{gembuilddir}
gem install --local --install-dir %{gembuilddir} --force %{SOURCE0}
mkdir -p %{buildroot}/%{_bindir}
mv %{gembuilddir}/bin/* %{buildroot}/%{_bindir}
rmdir %{gembuilddir}/bin

%clean
%{__rm} -rf %{buildroot}

%files
%defattr(-, root, root)
%{_bindir}/todo
%{gemdir}/gems/todo-0.0.1/bin/todo
%{gemdir}/gems/todo-0.0.1/lib/todo/version.rb
%{gemdir}/gems/todo-0.0.1/lib/todo.rb
%doc %{gemdir}/gems/todo-0.0.1/README.rdoc


%doc %{gemdir}/doc/todo-0.0.1
%{gemdir}/cache/pkg/todo-0.0.1.gem
%{gemdir}/specifications/pkg/todo-0.0.1.gemspec

%changelog
