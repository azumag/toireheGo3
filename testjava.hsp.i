##0 "hspdef.as"






















































































































##0 "testjava.hsp"
*top
##0 "sss.as"
#uselib "sss.hpi"

#func ss_init ss_init $202
#func ss_gcopy ss_gcopy $202
#func ss_blend ss_blend $202
#func ss_blend8 ss_blend8 $202
#func ss_check ss_check $202
#func ss_rnd ss_rnd $202
#func ss_randomize ss_randomize $202

#func mm_await mm_await $202
#func mm_beginperiod mm_beginperiod $202
#func mm_endperiod mm_endperiod $100
#func mm_getminperiod mm_getminperiod $202
#func mm_gettime mm_gettime $202
#func mm_wait mm_wait $202

#func dx_init ds_init $202
#func dx_load ds_load $202
#func dx_splay ds_splay $202
#func dx_sstop ds_sstop $202
#func dx_play ds_play $202
#func dx_loop ds_loop $202
#func dx_stop ds_stop $202
#func dx_stopall ds_stopall $202
#func dx_svol ds_svol $202
#func dx_span ds_span $202
#func dx_vol ds_vol $202
#func dx_pan ds_pan $202
#func dx_free ds_free $100

#func mmx_check mmx_check $202
#func mmx_sblend mmx_sblend $202
#func mmx_ablend mmx_ablend $202
##2 "testjava.hsp"
##0 "hspda.as"



#uselib "hspda.dll"
#func sortval sortval $83
#func sortstr sortstr $202
#func sortnote sortnote $202
#func sortget sortget $83
#func sortbye sortbye $100

#func csvstr csvstr $202
#func csvnote csvnote $87

#func xnotesel xnotesel $83
#func xnoteadd xnoteadd 6

#func rndf_ini rndf_ini $202
#func rndf_get rndf_get $202
#func rndf_geti rndf_geti $202

#func csvsel csvsel 1
#func csvres csvres $83
#func csvflag csvflag 0
#func csvopt csvopt 0
#func csvfind csvfind 6







##3 "testjava.hsp"
##0 "d3m.hsp"








goto@hsp *_d3m_exit









#deffunc d3rotate var v01@d3m,var v02@d3m,double v03@d3m,double v04@d3m,double v05@d3m

v01@d3m = v03@d3m * cos@hsp(v05@d3m) - v04@d3m * sin@hsp(v05@d3m)
v02@d3m = v03@d3m * sin@hsp(v05@d3m) + v04@d3m * cos@hsp(v05@d3m)

return@hsp















#deffunc d3setcamx double ssx@d3m,double ssy@d3m,double ssz@d3m,double ppx@d3m,double ppy@d3m,double ppz@d3m


cpx@d3m = ssx@d3m
cpy@d3m = ssy@d3m
cpz@d3m = ssz@d3m


ax@d3m = cpx@d3m - ppx@d3m
ay@d3m = cpy@d3m - ppy@d3m
az@d3m = cpz@d3m - ppz@d3m

bx@d3m = sqrt@hsp((ax@d3m) * (ax@d3m) + ( ay@d3m) * ( ay@d3m) + (0) * (0)) 
by@d3m = sqrt@hsp((ax@d3m) * (ax@d3m) + ( ay@d3m) * ( ay@d3m) + ( az@d3m) * ( az@d3m)) 

if@hsp bx@d3m ! 0.0 {
cosxy@d3m = ay@d3m / bx@d3m
sinxy@d3m = ax@d3m / bx@d3m
}
if@hsp by@d3m ! 0.0 {
cosaz@d3m = -bx@d3m / by@d3m
sinaz@d3m = az@d3m / by@d3m
}


wincx@d3m = 0.0 +  ginfo@hsp(12) / 2
wincy@d3m = 0.0 +  ginfo@hsp(13) / 2
zoom@d3m  = 0.1 +  ginfo@hsp(13)


mref@hsp df@d3m, 64

return@hsp











































#deffunc d3transx double v01@d3m,double v02@d3m,double v03@d3m

vx@d3m=( v01@d3m)-cpx@d3m : vy@d3m=( v02@d3m)-cpy@d3m : vz@d3m=( v03@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

return@hsp



























#deffunc d3line double ppx@d3m,double ppy@d3m,double ppz@d3m,double ssx@d3m,double ssy@d3m,double ssz@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	 dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 dz@d3m = ( dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 df@d3m = ( dz@d3m > 0.05) : 	if@hsp  df@d3m { 		  dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  dz@d3m : 		 dy@d3m = wincy@d3m + ( dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  dz@d3m 	}
vx@d3m=( ssx@d3m)-cpx@d3m : vy@d3m=( ssy@d3m)-cpy@d3m : vz@d3m=( ssz@d3m)-cpz@d3m : 	 ey@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 ez@d3m = ( ey@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 ef@d3m = ( ez@d3m > 0.05) : 	if@hsp  ef@d3m { 		  ex@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  ez@d3m : 		 ey@d3m = wincy@d3m + ( ey@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  ez@d3m 	}


if@hsp df@d3m & ef@d3m {
line@hsp dx@d3m, dy@d3m, ex@d3m, ey@d3m
return@hsp
}


if@hsp df@d3m | ef@d3m {
if@hsp df@d3m {
pos@hsp dx@d3m, dy@d3m
ax@d3m = ppx@d3m : ay@d3m = ppy@d3m : az@d3m = ppz@d3m
bx@d3m = ssx@d3m : by@d3m = ssy@d3m : bz@d3m = ssz@d3m
} else@hsp {
pos@hsp ex@d3m, ey@d3m
ax@d3m = ssx@d3m : ay@d3m = ssy@d3m : az@d3m = ssz@d3m
bx@d3m = ppx@d3m : by@d3m = ppy@d3m : bz@d3m = ppz@d3m
}
repeat@hsp 10
cx@d3m = (ax@d3m + bx@d3m) / 2
cy@d3m = (ay@d3m + by@d3m) / 2
cz@d3m = (az@d3m + bz@d3m) / 2
vx@d3m=( cx@d3m)-cpx@d3m : vy@d3m=( cy@d3m)-cpy@d3m : vz@d3m=( cz@d3m)-cpz@d3m : 	 ey@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 ez@d3m = ( ey@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 af@d3m = ( ez@d3m > 0.05) : 	if@hsp  af@d3m { 		  ex@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  ez@d3m : 		 ey@d3m = wincy@d3m + ( ey@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  ez@d3m 	}
if@hsp af@d3m {
ax@d3m = cx@d3m : ay@d3m = cy@d3m : az@d3m = cz@d3m
line@hsp ex@d3m, ey@d3m
} else@hsp {
bx@d3m = cx@d3m : by@d3m = cy@d3m : bz@d3m = cz@d3m
}
loop@hsp
}

return@hsp




#deffunc d3arrow double v11@d3m,double v12@d3m,double v13@d3m,double v14@d3m,double v15@d3m,double v16@d3m

d3line v11@d3m, v12@d3m, v13@d3m,  v14@d3m, v15@d3m, v16@d3m

if@hsp df@d3m & ef@d3m {

vx@d3m=( (v11@d3m * 9 + v14@d3m) / 10)-cpx@d3m : vy@d3m=( (v12@d3m * 9 + v15@d3m) / 10)-cpy@d3m : vz@d3m=( (v13@d3m * 9 + v16@d3m) / 10)-cpz@d3m : 	 ay@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	 az@d3m = ( ay@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	 af@d3m = ( az@d3m > 0.05) : 	if@hsp  af@d3m { 		  ax@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) /  az@d3m : 		 ay@d3m = wincy@d3m + ( ay@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) /  az@d3m 	}


a@d3m = atan@hsp(dy@d3m-ey@d3m, dx@d3m-ex@d3m)
r@d3m = sqrt@hsp((v11@d3m-v14@d3m) * (v11@d3m-v14@d3m) + ( v12@d3m-v15@d3m) * ( v12@d3m-v15@d3m) + ( v13@d3m-v16@d3m) * ( v13@d3m-v16@d3m))  / az@d3m / 30
bx@d3m = cos@hsp(a@d3m) * r@d3m
by@d3m = sin@hsp(a@d3m) * r@d3m


line@hsp dx@d3m, dy@d3m,  ax@d3m - by@d3m, ay@d3m + bx@d3m
line@hsp dx@d3m, dy@d3m,  ax@d3m + by@d3m, ay@d3m - bx@d3m
}

return@hsp




#deffunc d3box double v11@d3m,double v12@d3m,double v13@d3m,double v14@d3m,double v15@d3m,double v16@d3m

d3line v11@d3m, v12@d3m, v13@d3m,  v14@d3m, v12@d3m, v13@d3m
d3line v11@d3m, v15@d3m, v13@d3m,  v14@d3m, v15@d3m, v13@d3m
d3line v11@d3m, v15@d3m, v16@d3m,  v14@d3m, v15@d3m, v16@d3m
d3line v11@d3m, v12@d3m, v13@d3m,  v11@d3m, v12@d3m, v16@d3m
d3line v11@d3m, v15@d3m, v13@d3m,  v11@d3m, v12@d3m, v13@d3m
d3line v11@d3m, v15@d3m, v16@d3m,  v11@d3m, v15@d3m, v13@d3m
d3line v11@d3m, v12@d3m, v16@d3m,  v11@d3m, v15@d3m, v16@d3m
d3line v14@d3m, v12@d3m, v16@d3m,  v11@d3m, v12@d3m, v16@d3m
d3line v14@d3m, v15@d3m, v13@d3m,  v14@d3m, v15@d3m, v16@d3m
d3line v14@d3m, v12@d3m, v13@d3m,  v14@d3m, v15@d3m, v13@d3m
d3line v14@d3m, v12@d3m, v16@d3m,  v14@d3m, v12@d3m, v13@d3m
d3line v14@d3m, v15@d3m, v16@d3m,  v14@d3m, v12@d3m, v16@d3m

return@hsp




#deffunc d3circle double v01@d3m,double v02@d3m,double v03@d3m,double v04@d3m,int v05@d3m

vx@d3m=( v01@d3m)-cpx@d3m : vy@d3m=( v02@d3m)-cpy@d3m : vz@d3m=( v03@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m {
r@d3m = v04@d3m / dz@d3m
circle@hsp dx@d3m - r@d3m, dy@d3m - r@d3m, dx@d3m + r@d3m, dy@d3m + r@d3m, v05@d3m
}
return@hsp




#deffunc d3mes str pmsg@d3m,double ppx@d3m,double ppy@d3m,double ppz@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m {
pos@hsp 0, -32000
mes@hsp pmsg@d3m
pos@hsp dx@d3m -  ginfo@hsp(14) / 2, dy@d3m -  ginfo@hsp(15) / 2
mes@hsp pmsg@d3m
}
return@hsp









#deffunc d3lineto double ppx@d3m,double ppy@d3m,double ppz@d3m

ex@d3m = dx@d3m
ey@d3m = dy@d3m
ef@d3m = df@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m & ef@d3m {
line@hsp dx@d3m, dy@d3m, ex@d3m, ey@d3m
}
return@hsp



















#deffunc d3particle int ppi@d3m,double ppx@d3m,double ppy@d3m,double ppz@d3m,double ppr@d3m

vx@d3m=( ppx@d3m)-cpx@d3m : vy@d3m=( ppy@d3m)-cpy@d3m : vz@d3m=( ppz@d3m)-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}

if@hsp df@d3m {
r@d3m = int@hsp(ppr@d3m / dz@d3m)
if@hsp (r@d3m > 0) & (abs@hsp(dx@d3m) < 10000) & (abs@hsp(dy@d3m) < 10000) {
y@d3m = ppi@d3m * 112

if@hsp r@d3m <= 10 {


pos@hsp dx@d3m - r@d3m, dy@d3m - r@d3m
gcopy@hsp 29,  112, (r@d3m-1)*r@d3m + y@d3m, r@d3m*2, r@d3m*2

} else@hsp {


pdx@d3m = -r@d3m + dx@d3m,  r@d3m + dx@d3m,  r@d3m + dx@d3m, -r@d3m + dx@d3m
pdy@d3m = -r@d3m + dy@d3m, -r@d3m + dy@d3m,  r@d3m + dy@d3m,  r@d3m + dy@d3m

psx@d3m = 0,  111, 111, 0
psy@d3m = y@d3m, y@d3m, y@d3m + 111, y@d3m + 111

gsquare@hsp 29, pdx@d3m, pdy@d3m, psx@d3m, psy@d3m
}
}
}

return@hsp




#deffunc d3particlem int ppi@d3m,double ppr@d3m

if@hsp df@d3m {
r@d3m = int@hsp(ppr@d3m / dz@d3m)
if@hsp (r@d3m > 0) & (abs@hsp(dx@d3m) < 10000) & (abs@hsp(dy@d3m) < 10000) {
y@d3m = ppi@d3m * 112

if@hsp r@d3m <= 10 {


pos@hsp dx@d3m - r@d3m, dy@d3m - r@d3m
gcopy@hsp 29,  112, (r@d3m-1)*r@d3m + y@d3m, r@d3m*2, r@d3m*2

} else@hsp {


pdx@d3m = -r@d3m + dx@d3m,  r@d3m + dx@d3m,  r@d3m + dx@d3m, -r@d3m + dx@d3m
pdy@d3m = -r@d3m + dy@d3m, -r@d3m + dy@d3m,  r@d3m + dy@d3m,  r@d3m + dy@d3m

psx@d3m = 0,  111, 111, 0
psy@d3m = y@d3m, y@d3m, y@d3m + 111, y@d3m + 111

gsquare@hsp 29, pdx@d3m, pdy@d3m, psx@d3m, psy@d3m
}
}
}

return@hsp




#deffunc d3createptc int ppi@d3m,int v02@d3m,int v03@d3m,int v04@d3m,int v05@d3m,int v06@d3m


b@d3m =  ginfo@hsp(3)



if@hsp ptc_inited@d3m ! 100 {
buffer@hsp 29, 112 + 10 * 2, 112 * 32
ptc_inited@d3m = 100
} else@hsp {
gsel@hsp 29
}
y@d3m = 112 * ppi@d3m



if@hsp v05@d3m {


pos@hsp 0, y@d3m
gzoom@hsp 112, 112, v02@d3m, v03@d3m, v04@d3m, v05@d3m, v06@d3m, 1

} else@hsp {


a@d3m = 112 / 2
color@hsp
boxf@hsp , y@d3m, , y@d3m + 111
repeat@hsp a@d3m
f@d3m = 1.0 + cnt@hsp



f@d3m = f@d3m * (f@d3m + a@d3m) / a@d3m / a@d3m / 2	

color@hsp f@d3m * v02@d3m, f@d3m * v03@d3m, f@d3m * v04@d3m
circle@hsp cnt@hsp, y@d3m + cnt@hsp, 112 - cnt@hsp, y@d3m + 112 - cnt@hsp
loop@hsp
}



repeat@hsp 10, 1
r@d3m = cnt@hsp
pos@hsp 112, (r@d3m-1)*r@d3m + y@d3m
gzoom@hsp r@d3m*2, r@d3m*2,  29,  0, y@d3m, 112, 112,  1
loop@hsp



gsel@hsp b@d3m

return@hsp




















#deffunc d3texture array aryx@d3m,array aryy@d3m,array aryz@d3m,int ppi@d3m,int ppx@d3m,int ppy@d3m,int ppw@d3m,int pph@d3m


repeat@hsp 4
vx@d3m=( double@hsp( aryx@d3m(cnt@hsp) ))-cpx@d3m : vy@d3m=( double@hsp( aryy@d3m(cnt@hsp) ))-cpy@d3m : vz@d3m=( double@hsp( aryz@d3m(cnt@hsp) ))-cpz@d3m : 	dy@d3m = vx@d3m * sinxy@d3m + vy@d3m * cosxy@d3m : 	dz@d3m = (dy@d3m * cosaz@d3m - vz@d3m * sinaz@d3m) / zoom@d3m : 	df@d3m = (dz@d3m > 0.05) : 	if@hsp df@d3m { 		dx@d3m = wincx@d3m + (vy@d3m * sinxy@d3m - vx@d3m * cosxy@d3m) / dz@d3m : 		dy@d3m = wincy@d3m + (dy@d3m * sinaz@d3m + vz@d3m * cosaz@d3m) / dz@d3m 	}


if@hsp abs@hsp(dx@d3m) > 30000 | abs@hsp(dy@d3m) > 30000 : df@d3m = 0

if@hsp df@d3m = 0 : break@hsp 

pdx@d3m(cnt@hsp) = int@hsp( dx@d3m )
pdy@d3m(cnt@hsp) = int@hsp( dy@d3m )
loop@hsp

if@hsp df@d3m {
if@hsp ppi@d3m >= 0 {
psx@d3m = ppx@d3m, ppx@d3m+ppw@d3m-1, ppx@d3m+ppw@d3m-1, ppx@d3m
psy@d3m = ppy@d3m, ppy@d3m,       ppy@d3m+pph@d3m-1, ppy@d3m+pph@d3m-1
gsquare@hsp ppi@d3m, pdx@d3m, pdy@d3m, psx@d3m, psy@d3m
} else@hsp {
gsquare@hsp ppi@d3m, pdx@d3m, pdy@d3m
}
}

return@hsp















#uselib "winmm.dll"
#cfunc d3timer "timeGetTime"




#defcfunc d3getfps 

a@d3m = d3timer() / 500
fpss@d3m(   a@d3m  & 7)++
fpss@d3m((a@d3m+1) & 7) = 0
fpss@d3m((a@d3m+2) & 7) = 0

return@hsp fpss@d3m((a@d3m-1) & 7) + fpss@d3m((a@d3m-2) & 7)



*_d3m_exit


dim@hsp fpss@d3m, 8
d3setcamx  -1000,  0,  0, 0, 0, 0
##4 "testjava.hsp"


mes@hsp "三角関数テーブル作成中"
dim@hsp sina,360 : dim@hsp cosa,360	
cosa.0=10000 : sina.0=0
cosa.1=9999 : sina.1=175
repeat@hsp 358,1
ent=cnt@hsp+1
cosa.ent=((cosa.1*cosa.cnt@hsp)-(sina.1*sina.cnt@hsp))/10000
sina.ent=((sina.1*cosa.cnt@hsp)+(cosa.1*sina.cnt@hsp))/10000
loop@hsp
mes@hsp "完了"


mes@hsp "擬似オブジェクトの配列作成中"
tmax=1500				
dim@hsp tx,tmax				
dim@hsp ty,tmax				
dim@hsp tf,tmax				
dim@hsp txv,tmax			
dim@hsp tyv,tmax			
dim@hsp tx2,tmax			
dim@hsp ty2,tmax			
dim@hsp tc,tmax				
dim@hsp ts,tmax				
dim@hsp tcx,tmax			
dim@hsp tcy,tmax			
dim@hsp hitchklenghx,tmax	
dim@hsp hitchklenghy,tmax	
dim@hsp objtimek,tmax		
dim@hsp eh2,tmax			
dim@hsp dis,tmax			
dim@hsp objtimek2,tmax		
dim@hsp objtimek3,tmax		
dim@hsp tcplusx,tmax
dim@hsp tcplusy,tmax
dimtype@hsp  kaitendo,3,tmax,0,0,0		
dimtype@hsp  tk,3,tmax,0,0,0
tmax=1500
repeat@hsp tmax
tf.cnt@hsp=-1
loop@hsp



maxdansu=360

dim@hsp shotx,maxdansu		
dim@hsp shoty,maxdansu		
dim@hsp shotf,maxdansu			
dim@hsp shotxv,maxdansu	
dim@hsp shotyv,maxdansu	
dim@hsp shotx2,maxdansu		
dim@hsp shoty2,maxdansu		
dim@hsp shotcx,maxdansu		
dim@hsp shotcy,maxdansu		
dim@hsp shotdis,maxdansu
maxdansu=360
mes@hsp "完了"

