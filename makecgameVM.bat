pushd \quake3\baseq3
copy /Y pak-cgamevm.pk3 pak-cgamevm.pk3.BAK
del pak-cgamevm.pk3
zip pak-cgamevm.pk3 vm\cgame.qvm
copy /Y %1\pak-cgamevm.pk3 %1\pak-cgamevm.pk3.BAK
copy /Y pak-cgamevm.pk3 %1
popd
