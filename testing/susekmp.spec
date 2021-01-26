%package guest-KMP
Summary:        Guest kernel modules for VirtualBox
Group:          System/Emulators/PC
Supplements:    modalias(x86cpu:vendor%%3A0002%%3Afamily%%3A*%%3Amodel%%3A*%%3Afeature%%3A*)
Supplements:    modalias(dmi:*:[bs]vnD[Ee][Ll][Ll]*:*)
#SUSE specify macro to define guest kmp package                                
%{?suse_kernel_module_package:%{suse_kernel_module_package} -p %{SOURCE8} -n %{name}-guest -f %{SOURCE6} kdump um xen xenpae}
%kernel_module_package -p %{name}-kmp-preamble
