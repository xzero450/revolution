pushd \quake3\baseq3
copy /Y pak-uivm.pk3 pak-uivm.pk3.BAK
del pak-uivm.pk3
zip pak-uivm.pk3 vm\ui.qvm
copy /Y %1\pak-uivm.pk3 %1\pak-uivm.pk3.BAK
copy /Y pak-uivm.pk3 %1
popd
