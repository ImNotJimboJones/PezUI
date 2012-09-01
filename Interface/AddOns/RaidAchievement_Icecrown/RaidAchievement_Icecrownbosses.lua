--общий для фейлов с 1 удара
function icrafailnoreason(icranrach, prichina, quant)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
raachdone1=false
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
if GetInstanceDifficulty()==4 or GetInstanceDifficulty()==6 then
raplaysound(1,icraspisokach10[icranrach])
end
if GetInstanceDifficulty()==5 or GetInstanceDifficulty()==7 then
raplaysound(1,icraspisokach25[icranrach])
end

pseareportfailnoreason(prichina, quant)
end


--общий для выполненого с 1 события НО ДЛЯ 2 ачивки
function icraachcompl(icranrach)
raachdone2=nil
if GetInstanceDifficulty()==4 or GetInstanceDifficulty()==6 then
raplaysound(2,icraspisokach10[icranrach])
end
if GetInstanceDifficulty()==5 or GetInstanceDifficulty()==7 then
raplaysound(2,icraspisokach25[icranrach])
end
pseareportallok()
end