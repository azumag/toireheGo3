##0 "hspdef.as"






















































































































##0 "main2.hsp"
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







##1 "main2.hsp"
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
##2 "main2.hsp"
##0 "dsoundex.as"
#uselib	"dsoundex.hpi"













#func ds_getdev	ds_getdev	$11
#func ds_setdev	ds_setdev	$0

#func ds_init	ds_init	$22
#func ds_load	ds_load	$6
#func ds_load2	ds_load2	$1
#func ds_memload	ds_memload	$1
#func ds_create	ds_create	$0
#func ds_write	ds_write	$1
#func ds_play	ds_play	$0
#func ds_loop	ds_loop	$0
#func ds_stop	ds_stop	$0
#func ds_getf	ds_getf	$0
#func ds_setf	ds_setf	$0
#func ds_getp	ds_getp	$0
#func ds_setp	ds_setp	$0
#func ds_stat	ds_stat	$0
#func ds_vol	ds_vol	$0
#func ds_pan	ds_pan	$0
#func ds_dup	ds_dup	$0
#func ds_rel	ds_rel	$0
#func ds_bye	ds_bye	$0
#func ds_free	ds_free	$100
#func timer	timer	$0

#func seq_read	seq_read	$1
#func seq_play	seq_play	$0
#func seq_stat	seq_stat	$0
#func seq_isplay	seq_isplay	$0
#func seq_stop	seq_stop	$0
#func seq_bye	seq_bye	$100

##3 "main2.hsp"
##0 "hmm.as"
#uselib "hmm.dll"


#func hmminit HMMINIT 2
#func hmmend HMMEND $100


#func dsinit DSINIT 2
#func dsend DSEND 0
#func dsrelease DSRELEASE 0


#func dsloadfname DSLOADFNAME 6
#func dsloadfname2 DSLOADFNAME2 6
#func dsloadmemory DSLOADMEMORY 1


#func dsplay DSPLAY 0
#func dsstop DSSTOP 0


#func dsgetvolume DSGETVOLUME 0
#func dssetvolume DSSETVOLUME 0
#func dsgetmastervolume DSGETMASTERVOLUME 0
#func dssetmastervolume DSSETMASTERVOLUME 0
#func dssetmasterformat DSSETMASTERFORMAT 0
#func dscheckplay CHECKPLAY 0
#func dsduplicate DSDUPLICATE 0


#func dminit DMINIT 2
#func dmend DMEND 0
#func dmloadfname DMLOADFNAME 6
#func dmloadmemory DMLOADMEMORY 1
#func dmplay DMPLAY 0
#func dmstop DMSTOP 2

#func diinit DIINIT 2
#func diend DIEND 0
#func digetjoynum DIGETJOYNUM 0
#func digetjoystate DIGETJOYSTATE 1
#func digetpastjoystate DIGETPASTJOYSTATE 1
#func digetkeepjoystate DIGETKEEPJOYSTATE 1
#func digetmomentjoystate DIGETMOMENTJOYSTATE 1
#func digetkeystate DIGETKEYSTATE 1
#func digetpastkeystate DIGETPASTKEYSTATE 1
#func digetkeepkeystate DIGETKEEPKEYSTATE 1
#func digetmomentkeystate DIGETMOMENTKEYSTATE 1
#func distick DISTICK 1
#func diplayeffect DIPLAYEFFECT 0
#func distopeffect DISTOPEFFECT 0

#func hmmbiton HMMBITON 1
#func hmmbitoff HMMBITOFF 1
#func hmmbitcheck HMMBITCHECK 0

#func hmmgetfps HMMGETFPS 1
#func hmmgetsin HMMGETSIN 1

#func hmmhitcheck HMMHITCHECK $202
#func hmmhitchecksetindex HMMHITCHECKSETINDEX $202


#func ddinit DDINIT 2
#func ddscreen DDSCREEN 0
#func ddgsel DDGSEL 0
#func ddloadfname DDLOADFNAME 6
#func ddbuffer DDBUFFER 0
#func ddsetrect DDSETRECT 0
#func ddgcopy DDGCOPY 0
#func ddboxf DDBOXF 0
#func ddcolor DDCOLOR 0
#func ddprint DDPRINT 6
#func dddrawtext DDDRAWTEXT 6
#func ddredraw DDREDRAW 0
#func ddsetrenewaltiming DDSETRENEWALTIMING 0
#func ddend DDEND 0
#func ddblendgcopy DDBLENDGCOPY 0
#func ddreverse DDREVERSE 0
#func ddaddgcopy DDADDGCOPY 0
#func ddsubgcopy DDSUBGCOPY 0
#func ddloadmemory DDLOADMEMORY 1
#func ddgzoom DDGZOOM 0
#func ddpos DDPOS 0
#func ddrotategcopy DDROTATEGCOPY 0
#func ddgcopy2 DDGCOPY2 0
#func ddaddgcopyall DDADDGCOPYALL 1
#func ddbgcopy DDBGCOPY 0
#func ddpaintgcopy DDPAINTGCOPY 0

#func dginit DGINIT 2
#func dgend DGEND 0
#func dgscreen DGSCREEN $202
#func dgcolor DGCOLOR 0
#func dgclear DGCLEAR 0
#func dgrenewaltiming DGRENEWALTIMING 0
#func dgredraw DGREDRAW 0
#func dggsel DGGSEL 0
#func dgbuffer DGBUFFER 0
#func dgloadfname DGLOADFNAME 6
#func dgloadmemory DGLOADMEMORY 1
#func dgpos DGPOS 0
#func dgrect DGRECT 0
#func dgscaleandangle DGSCALEANDANGLE 0
#func dgblendmode DGBLENDMODE 0
#func dggcopy DGGCOPY 0
#func dgfont DGFONT 6
#func dgdrawtext DGDRAWTEXT 6
#func dgbmpsave DGBMPSAVE 6
#func dgtexture DGTEXTURE 0
#func dgaddprimitive DGADDPRIMITIVE 0
#func dgdrawprimitive DGDRAWPRIMITIVE 0
#func dgcreateprimitive DGCREATEPRIMITIVE 0
#func dgline DGLINE 0

#func dshinit DSHINIT 2
#func dshend DSHEND 0
#func dshloadfname DSHLOADFNAME 6
#func dshplay DSHPLAY $202
#func dshstop DSHSTOP 0
#func dshpause DSHPAUSE 0
#func dshsetfullscreen DSHSETFULLSCREEN 0
#func dshsetseek DSHSETSEEK 0
#func dshsetrate DSHSETRATE 0
#func dshsetvideoparam DSHSETVIDEOPARAM $202
#func dshgetoriginalvideosize DSHGETORIGINALVIDEOSIZE $202
#func dshcheckplay DSHCHECKPLAY 0
#func dshsetvolume DSHSETVOLUME 0
#func dshgetplayposition DSHGETPLAYPOSITION $202
#func dshsetvideovisible DSHSETVIDEOVISIBLE 0
#func dshsetmovietodgbuffer DSHSETMOVIETODGBUFFER 0








































































##4 "main2.hsp"
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
##5 "main2.hsp"

ds_init
hmminit 2

goto@hsp *start 

##0 "moretamodule.hsp"
#deffunc getick 

name=0


getkey@hsp left,37
getkey@hsp right,39
getkey@hsp up,38
getkey@hsp down,40
getkey@hsp sps,32


getkey@hsp ent,13
getkey@hsp xkey,88
getkey@hsp akey,65
getkey@hsp skey,83
getkey@hsp ckey,67
getkey@hsp ctrl,17



if@hsp left=1:name+=1
if@hsp right=1:name+=4
if@hsp up=1:name+=2
if@hsp down=1:name+=8
if@hsp sps=1:name+=16


if@hsp ent=0:buf=0
if@hsp ent=1&buf=0|ctrl=1{
buf=1
name+=32
}

if@hsp xkey=0:buf2=0
if@hsp xkey=1&buf2=0{
buf2=1
name+=64
}
if@hsp ckey=0:buf6=0
if@hsp ckey=1&buf6=0{
buf6=1
name+=128
}



if@hsp replayf=1{
if@hsp akey=0:buf3=0
if@hsp akey=1&buf3=0{
buf3=1
waitkaunt+=5
ds_play 1
color@hsp 255,255,255
font@hsp "MS ゴシック",16
pos@hsp 150,220:mes@hsp waitkaunt

}
if@hsp skey=0:buf4=0
if@hsp skey=1&buf4=0{
buf4=1
waitkaunt-=5

ds_play 1
color@hsp 255,255,255
font@hsp "MS ゴシック",16
pos@hsp 150,220:mes@hsp waitkaunt

}
}


return@hsp name

#deffunc getsankak int af


kyorx=tx2.af-mycharcenterx
kyory=ty2.af-mycharcentery
if@hsp tx2.af>mycharcenterx:hantenx=1:else@hsp:hantenx=0
if@hsp ty2.af>mycharcentery:hanteny=1:else@hsp:hanteny=0

c=atan@hsp(kyory,kyorix)


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)

b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b
if@hsp b>=360:b=4
if@hsp b<=0:b=4
modc=double@hsp((b+270)*3.1415926535897932384626433832795)/180


return@hsp b,c,modc
#deffunc getsankaktcy int af


kyorx=tcx.af-mycharcenterx
kyory=tcy.af-mycharcentery
if@hsp tcx.af>mycharcenterx:hantenx=1:else@hsp:hantenx=0
if@hsp tcy.af>mycharcentery:hanteny=1:else@hsp:hanteny=0

c=atan@hsp(kyory,kyorix)


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)

b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b
if@hsp b>=360:b=4
if@hsp b<=0:b=4
modc=double@hsp((b+270)*3.1415926535897932384626433832795)/180

return@hsp b
#deffunc getsankak2 int af,int as


kyorx=shotx2.as-tcx.af
kyory=shoty2.as-tcy.af
if@hsp shotx2.as>tcx.af:hantenx=1:else@hsp:hantenx=0
if@hsp shoty2.as>tcy.af:hanteny=1:else@hsp:hanteny=0


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)
b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b

if@hsp b>=360:b=0
if@hsp b<=0:b=0

return@hsp b
#deffunc getsankak3 int af


kyorx=int@hsp(exa)-mycharcenterx
kyory=int@hsp(exy)-mycharcentery
if@hsp int@hsp(exa)>mycharcenterx:hantenx=1:else@hsp:hantenx=0
if@hsp int@hsp(exy)>mycharcentery:hanteny=1:else@hsp:hanteny=0

c=atan@hsp(kyory,kyorix)


kyory=abs@hsp(kyory)
kyorx=abs@hsp(kyorx)
if@hsp kyorx=0 :kyorx+=1
if@hsp kyory=0 :kyory+=1


zahyo=double@hsp(kyory)/double@hsp(kyorx)
a=atan@hsp(zahyo)

b=a*180/3.1415926535897932384626433832795
b=int@hsp(b)

if@hsp hantenx=1:b=180-b
if@hsp hanteny=1:b=360-b
if@hsp b>=360:b=4
if@hsp b<=0:b=4


return@hsp b,c
#deffunc resetmove int af,int kakudo,int sokudo

eh2.af=kakudo
txv.af=cosa(eh2.af)/sokudo : tyv.af=sina(eh2.af)/sokudo

return@hsp
#deffunc nohit int af


hitchklenghx.af=-1000
hitchklenghy.af=-1000


tcplusx.af=-1000
tcplusy.af=-1000

return@hsp
#deffunc disbullet int af


repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13|ts.cnt@hsp=19|ts.cnt@hsp=20|ts.cnt@hsp=24|ts.cnt@hsp=26|ts.cnt@hsp=27|ts.cnt@hsp=37|ts.cnt@hsp=41|ts.cnt@hsp=42|ts.cnt@hsp=43:dis.cnt@hsp=1
loop@hsp

return@hsp
##12 "main2.hsp"

*start

randomize@hsp

























































screen@hsp 0,440,440

cls@hsp 
color@hsp 0,0,0
pos@hsp 0,0
mes@hsp "now loading"
*top


dim@hsp sina,360 : dim@hsp cosa,360	
cosa.0=10000 : sina.0=0
cosa.1=9999 : sina.1=175
repeat@hsp 358,1
ent=cnt@hsp+1
cosa.ent=((cosa.1*cosa.cnt@hsp)-(sina.1*sina.cnt@hsp))/10000
sina.ent=((sina.1*cosa.cnt@hsp)+(cosa.1*sina.cnt@hsp))/10000
loop@hsp


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
dimtype@hsp  kaitendo,3,tmax,0,0,0		
dimtype@hsp  tk,3,tmax,0,0,0
tmax=1500
repeat@hsp tmax
tf.cnt@hsp=-1
loop@hsp


maxdansu=360



dim@hsp shotf,maxdansu			




dim@hsp shotcx,maxdansu		
dim@hsp shotcy,maxdansu		
dim@hsp shotdis,maxdansu
maxdansu=360


ket=220				
 sdim@hsp enemydate,3000
dansu=2				

life=4				
drawhantei=0		
sp=1				
waitkaunt=17.0		
chp=150				
bhp=150				
haikeihosi=0		

menu=0				
fullscr=0			

waponx=440			
waponx2=440			
repbuf=56400		
sdim@hsp replay,repbuf	
dim@hsp morkage,30		
replayname=""		
ketx=180
sumfps=50			
maxcont=3			
bload@hsp "configb.cfg",waitkaunt	
bload@hsp "configa.cfg",haikeihosi	

tikyukaiten=0.0		

syatei=1			
kasurikaunter=500	


tuyos=0				
if@hsp tuyos=1:kasurikaunter=25000:dansu=6:shotlv=5




buffer@hsp 3,,,
picload@hsp "img/mychar.GIF",1
buffer@hsp 4,,,
picload@hsp "img/zako.gif",1
buffer@hsp 5,,,
picload@hsp "img/alltama256.GIF",1
buffer@hsp 6,,,
picload@hsp "img/haikei.gif",1
buffer@hsp 7,1470,64,
picload@hsp "img/chuboss1.GIF",1
buffer@hsp 8,,,
picload@hsp "img/system.GIF",1
buffer@hsp 9,,,
picload@hsp "img/boss.gif",1
buffer@hsp 10,,
picload@hsp "img/haikei2men.GIF",1
buffer@hsp 11,,
picload@hsp "img/dona1-3.GIF",1
buffer@hsp 12,,
picload@hsp "img/stars2.GIF",1
buffer@hsp 13,,
picload@hsp "img/bg_chip.GIF",1
buffer@hsp 14,,
picload@hsp "img/chainguard.gif",1
buffer@hsp 15,,
picload@hsp "sks4.bmp",1
buffer@hsp 16,680,1280
picload@hsp "img/cannon_charge_fire.GIF",1
buffer@hsp 17,,,
picload@hsp "toire.bmp",1







dmloadfname "music/stage1.mid", 4
dmloadfname "music/boss01a.mid", 2
dmloadfname "music/boss01b.mid", 3
dmloadfname "music/sea2.mid", 5
dmloadfname "music/stage2.mid",6
dmloadfname "music/katyhilla.mid",8
dmloadfname "music/katyhill_intro.mid",7
dmloadfname "music/Done_Gone.mid",10
dmloadfname "music/bbb_f.mid",11
dmloadfname "music/bbb_s.mid",13
dmloadfname "music/bbb_t.mid",14
dmloadfname "music/BBBS.mid",15
dmloadfname "music/end.mid",16

ds_load "sound/515.wav",1
ds_load "sound/bom.wav",2
ds_load "sound/zasizasi.wav",3
ds_load "sound/bokan.wav",4
ds_load "sound/poka.wav",5
ds_load "sound/bachi.wav",6
ds_load "sound/poi2.wav",7
ds_load "sound/kin.wav",8
ds_load "sound/boss01c.wav",9
ds_load "sound/bishao.wav",10
ds_load "sound/laser03.wav",11
ds_load "sound/gasha.wav",12
ds_load "sound/chinacnon.wav",13
ds_load "sound/laser.wav",14
mmload@hsp "sound/ka.mp3",11
mmload@hsp "sound/vman.mp3",12
mmload@hsp "sound/vman2.mp3",14
mmload@hsp "sound/end2.mp3",13
mmload@hsp "sound/orange.mp3",15,1
mmload@hsp "music/uzygame_s05.mid",2,1
mmload@hsp "music/Flexibility.mid",10


d3createptc  0,  255,  255,  255 
d3createptc  1,   64,  192,  255 
d3createptc  2,   255,  0, 	0 
*clsa
gsel@hsp 0

bsave@hsp "configb.cfg",waitkaunt
bsave@hsp "configa.cfg",haikeihosi


cls@hsp
*titleloop

gsel@hsp 0	
redraw@hsp 2

ct++
redraw@hsp 0

color@hsp , 8, 24
boxf@hsp

d3setcamx  0, 0, -500, 0, 0, 0

randomize@hsp 0
repeat@hsp 100
if@hsp haikeihosi=1:break@hsp
x = rnd@hsp(8000) - 4000
y = rnd@hsp(8000) - 4000
z = rnd@hsp(8000)
v = rnd@hsp(50) + 50

z = (ct * v + z) \ 8000 - 8000


gmode@hsp 5, , , 64
d3particle 1,  x, y, -z, 150


gmode@hsp 5, , , 255
d3particlem  0, 50

loop@hsp

color@hsp 255,0,0
font@hsp "MS ゴシック",20
pos@hsp 100,100
mes@hsp "トイレへＧＯ３"
gmode@hsp 5, , , 255
d3particle  0,-85,110,0, 50
gmode@hsp 2,42,51,
pos@hsp 100,120:gcopy@hsp 3,0,50,42,51



font@hsp "MS ゴシック",16:color@hsp 255,0,0
pos@hsp 200,220:mes@hsp " Play "
pos@hsp 200,240:mes@hsp " Replay"
pos@hsp 200,260:mes@hsp " Option"
pos@hsp 200,280:mes@hsp " Exit "
pos@hsp ketx,ket:mes@hsp "→ "
pos@hsp 380,420:mes@hsp "fps="+fps


gosub@hsp *key
if@hsp kettei=1:goto@hsp *stagestart


fps=d3getfps()
if@hsp waitkaunt<=0.0:waitkaunt=0

mm_await waitkaunt
await@hsp 1

redraw@hsp 1
goto@hsp *titleloop
*key

stick@hsp keyin

if@hsp keyin&8:ket+=20:menu+=1
if@hsp keyin&2:ket-=20:menu-=1

ket=limit@hsp(ket,220,280)
menu=limit@hsp(menu,0,3)
if@hsp keyin&36:kettei=1

return@hsp
*option
cls@hsp
mes@hsp "速度調整(FPSが50程度になるように設定してください）"
input@hsp waitkaunt,,,2

objsize@hsp 300,30
chkbox@hsp "当たり判定描画（重くてゲームにならない場合も。",drawhantei
chkbox@hsp "３面と背景の星を書かない(軽量化)",haikeihosi

objsize@hsp 100,20
button@hsp "設定＆もどる",*clsa
stop@hsp
*stagestart
kettei=0
stage=1
if@hsp menu=1:goto@hsp *replayload
if@hsp menu=2:goto@hsp *option
if@hsp menu=3:goto@hsp *kanzenexit
*stagestart2


cls@hsp
mes@hsp "Now loading"
if@hsp stage=1:dmplay 0, 4:kyokumei="Orange Blossom Special"
if@hsp stage=2:dmplay 0, 6:kyokumei="Jerusalem Ridge"
if@hsp stage=3:mmplay@hsp 15:kyokumei="Orange Blossom Special Arrange"
mx=160:my=440
mapy=0
if@hsp stage=2:mapx=-100

d3setcamx  0, 0, 10, 0, 0, 0


bload@hsp "stage"+stage+".dat",enemydate
notesel@hsp enemydate
sdim@hsp one,20, noteinfo@hsp(0)
sdim@hsp enemyline,20, noteinfo@hsp(0)	
csvline=""
repeat@hsp  noteinfo@hsp(0)
noteget@hsp one,cnt@hsp
csvnote csvline,one
enemyline.cnt@hsp=csvline
loop@hsp
gsel@hsp 0

if@hsp stage=3:goto@hsp *stage3loop

*mainloop

ct++
frame+=1
redraw@hsp 0



gosub@hsp *backg_screen
color@hsp 0,0,0
boxf@hsp 350,0,440,440

gosub@hsp *write_stage
gosub@hsp *keychk

gosub@hsp *write_status
gosub@hsp *write_mychar
gosub@hsp *put_shot
gosub@hsp *call_enemy

gosub@hsp *object_move

if@hsp hissatuf=1:gosub@hsp *moreta_wapon
if@hsp hissatuf=2:gosub@hsp *moreta_wapon2
if@hsp morerl=1:gosub@hsp *moreta_wapon2_2

if@hsp drawhantei=1{
color@hsp 255, 0, 0
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx+mycharuppery, mycharcentery+mycharrightx
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx+mycharuppery, mycharcentery-mycharrightx
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx-mycharuppery, mycharcentery-mycharrightx
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx-mycharuppery, mycharcentery+mycharrightx
}

gosub@hsp *hitchk


redraw@hsp 1


fps=d3getfps()
sumfps+=fps
heikinfps=(sumfps/frame)*1000
if@hsp waitkaunt<=0.0:waitkaunt=0

mm_await waitkaunt
await@hsp 0


goto@hsp *mainloop

*backg_screen


color@hsp 0,0,0
boxf@hsp 0,0,400,500
if@hsp stage=1{
pos@hsp 0,mapy:gcopy@hsp 6,0,0,352,440
pos@hsp 0,mapy-440:gcopy@hsp 6,0,0,352,440

mapy+=1
if@hsp mapy>=440:mapy=0

if@hsp frame\50=0{
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 :continue@hsp							
rrr=rnd@hsp(350)		
rr2=rnd@hsp(5)
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=11
tx.cnt@hsp=rrr*1000 :ty.cnt@hsp=0*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/4+rr2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/4+rr2	


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
}
}
if@hsp stage=2{
pos@hsp mapx,mapy:gcopy@hsp 10,0,0,575,440
pos@hsp mapx,mapy-440:gcopy@hsp 10,0,0,575,440

mapy+=1
if@hsp mapy>=440:mapy=0
}
if@hsp stage=3{

if@hsp frame\2=0{

repeat@hsp tmax
if@hsp utyusenf=1:break@hsp
if@hsp tf.cnt@hsp>0 :continue@hsp							

rrr=rnd@hsp(350)
if@hsp tiky>=150&tiky<=320:rrr=rnd@hsp(440)
rr2=rnd@hsp(3)
eh+
eh2.cnt@hsp=90										
if@hsp tiky>=150&tiky<=320:eh2.cnt@hsp=0
tf.cnt@hsp=1										
tc.cnt@hsp=0										
ts.cnt@hsp=29
tx.cnt@hsp=rrr*1000 :ty.cnt@hsp=0*1000			
if@hsp tiky>=150&tiky<=320:tx.cnt@hsp=0*1000 :ty.cnt@hsp=rrr*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/(1+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)/(1+rr2)	
if@hsp moretaspeed=5:txv.cnt@hsp=cosa(eh2.cnt@hsp)*(1+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)*(1+rr2)


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
}

mapy+=1:tikyuzoom+=2:
if@hsp frame\4=0:tiky+=1
gmode@hsp 2,265,265
pos@hsp 120+yokyu,300+tiky-300
grotate@hsp 12,355,0,tikyukaiten,(467)-tikyuzoom,(467)-tikyuzoom
if@hsp tiky>=150&tiky<=320:tikyukaiten-=0.01:tiky+=1:yokyu+=1
if@hsp tiky>=320:moretaspeed=5:tiky+=4

notesel@hsp enemyline.turn
noteget@hsp enemyname,0

if@hsp vman2f=1{
if@hsp frame\10=0:dosey+=1
pos@hsp 200,dosey:gmode@hsp 2,128,150
grotate@hsp 12,400,267,0,128,153
if@hsp dosey>=440:vman2f=0
}
if@hsp utyusenf2=1{
pos@hsp 15,utyusy2:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
pos@hsp 15,utyusy2-440:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
utyusy2+=5
if@hsp utyusy2>=440:utyusy2=0
}
if@hsp utyusenf=1{
pos@hsp 0,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
pos@hsp 0,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
utyusy+=15
if@hsp utyusy>=440:utyusy=0:utyusenf2=1
}

if@hsp tikyuzoom>=200{
tikyuzoom=199
hosis=rnd@hsp(10)
randomize@hsp
if@hsp hosis<1:hosis=5
if@hsp frame\hosis=0&haikeihosi=0{
repeat@hsp tmax

if@hsp tf.cnt@hsp>0 :continue@hsp							

rrr=rnd@hsp(350)
if@hsp tiky>=150&tiky<=320:rrr=rnd@hsp(440)
rr2=rnd@hsp(3)
eh+
eh2.cnt@hsp=90										
if@hsp tiky>=150&tiky<=320:eh2.cnt@hsp=0
tf.cnt@hsp=1										
tc.cnt@hsp=rr2										
ts.cnt@hsp=28
tx.cnt@hsp=rrr*1000 :ty.cnt@hsp=0*1000			
if@hsp tiky>=150&tiky<=320:tx.cnt@hsp=0*1000 :ty.cnt@hsp=rrr*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/(1+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)/(1+rr2)	
if@hsp moretaspeed=5:txv.cnt@hsp=cosa(eh2.cnt@hsp)*(3+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)*(3+rr2)



hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
}
}
if@hsp mapy>=440:mapy=0
}
if@hsp stage=4{
if@hsp utyusenf2=1{
pos@hsp 15,utyusy2:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
pos@hsp 15,utyusy2-440:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
if@hsp frame\4=0:utyusz+=1
if@hsp utyusz>=5:utyusz=5
utyusy2+=5-utyusz
if@hsp utyusy2>=440:utyusy2=0
}
if@hsp utyusenf=1{
pos@hsp 0,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
pos@hsp 0,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
if@hsp frame\4=0:utyusz2+=1
if@hsp utyusz2>=15:utyusz2=15
utyusy+=15-utyusz2
if@hsp utyusy>=440:utyusy=0:utyusenf2=1
}
}
if@hsp stage=5{
if@hsp utyusenf2=1{
pos@hsp 15,utyusy2:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
pos@hsp 15,utyusy2-440:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
if@hsp frame\4=0:utyusz+=1
if@hsp utyusz>=5:utyusz=5
utyusy2+=5-utyusz
if@hsp utyusy2>=440:utyusy2=0
}
if@hsp utyusenf=1{
pos@hsp 0,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
pos@hsp 0,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
if@hsp frame\4=0:utyusz2+=1
if@hsp utyusz2>=15:utyusz2=15
utyusy+=15-utyusz2
if@hsp utyusy>=440:utyusy=0:utyusenf2=1
}
}
if@hsp stage=6{

if@hsp frame\2=0{

repeat@hsp tmax

if@hsp tf.cnt@hsp>0 :continue@hsp							

rrr=rnd@hsp(350)
if@hsp tiky>=150&tiky<=320:rrr=rnd@hsp(440)
rr2=rnd@hsp(3)
eh+
eh2.cnt@hsp=90										
if@hsp tiky>=150&tiky<=320:eh2.cnt@hsp=0
tf.cnt@hsp=1										
tc.cnt@hsp=0										
ts.cnt@hsp=29
tx.cnt@hsp=rrr*1000 :ty.cnt@hsp=0*1000			
if@hsp tiky>=150&tiky<=320:tx.cnt@hsp=0*1000 :ty.cnt@hsp=rrr*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/(1+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)/(1+rr2)	
if@hsp moretaspeed=5:txv.cnt@hsp=cosa(eh2.cnt@hsp)*(1+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)*(1+rr2)


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
}

mapy+=1:tikyuzoom+=2:
if@hsp frame\4=0:tiky+=1
gmode@hsp 2,265,265
pos@hsp 120+yokyu,300+tiky-300
grotate@hsp 12,355,0,tikyukaiten,(467)-tikyuzoom,(467)-tikyuzoom
if@hsp tiky>=150&tiky<=320:tikyukaiten-=0.01:tiky+=1:yokyu+=1
if@hsp tiky>=320:moretaspeed=5:tiky+=4

notesel@hsp enemyline.turn
noteget@hsp enemyname,0

if@hsp vman2f=1{
if@hsp frame\10=0:dosey+=1
pos@hsp 200,dosey:gmode@hsp 2,128,150
grotate@hsp 12,400,267,0,128,153
if@hsp dosey>=440:vman2f=0
}
if@hsp utyusenf2=1{
pos@hsp 15,utyusy2:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
pos@hsp 15,utyusy2-440:gmode@hsp 2,355,440
gcopy@hsp 13,355,0,355,440
utyusy2+=5

}
if@hsp utyusenf=1{
pos@hsp 0,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
pos@hsp 0,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,0,0,84,440
pos@hsp 263,utyusy-440:gmode@hsp 1,84,440
gcopy@hsp 13,263,0,90,440
utyusy+=5

}

if@hsp tikyuzoom>=200{
tikyuzoom=199
hosis=rnd@hsp(10)
randomize@hsp
if@hsp hosis<1:hosis=5
if@hsp frame\hosis=0&haikeihosi=0{
repeat@hsp tmax

if@hsp tf.cnt@hsp>0 :continue@hsp							

rrr=rnd@hsp(350)
if@hsp tiky>=150&tiky<=320:rrr=rnd@hsp(440)
rr2=rnd@hsp(3)
eh+
eh2.cnt@hsp=90										
if@hsp tiky>=150&tiky<=320:eh2.cnt@hsp=0
tf.cnt@hsp=1										
tc.cnt@hsp=rr2										
ts.cnt@hsp=28
tx.cnt@hsp=rrr*1000 :ty.cnt@hsp=0*1000			
if@hsp tiky>=150&tiky<=320:tx.cnt@hsp=0*1000 :ty.cnt@hsp=rrr*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/(1+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)/(1+rr2)	
if@hsp moretaspeed=5:txv.cnt@hsp=cosa(eh2.cnt@hsp)*(3+rr2) : tyv.cnt@hsp=sina(eh2.cnt@hsp)*(3+rr2)



hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
}
}
if@hsp mapy>=440:mapy=0
}
return@hsp
*write_stage



if@hsp stage=1{
if@hsp titlex>=440:return@hsp
color@hsp 255,255,255
pos@hsp titlex,100:font@hsp "MS ゴシック",30:mes@hsp "Stage1"
titlex+=1







if@hsp titlex>=50:return@hsp
my-=3
}

if@hsp stage=2{
if@hsp titlex>=440:return@hsp
color@hsp 255,255,255
pos@hsp titlex,100:font@hsp "MS ゴシック",30:mes@hsp "Stage2"
titlex+=1
if@hsp titlex>=50:return@hsp
my-=3
}

if@hsp stage=3{
if@hsp titlex>=440:return@hsp
color@hsp 255,255,255
pos@hsp titlex,100:font@hsp "MS ゴシック",30:mes@hsp "Stage3"
titlex+=1
if@hsp titlex>=50:return@hsp
my=300
}
return@hsp
*keychk

if@hsp mutekif=1:return@hsp

if@hsp replayf=0{

getick
keyon=stat@hsp
poke@hsp replay,frame,keyon
}
if@hsp replayf=1{
getick
memcpy@hsp keyon,replay,1,0,frame
}


ido=4
syatei=1
if@hsp keyon&16:ido=2:syatei=2

if@hsp kaiwaf>=1{
if@hsp keyon&32{
kaiwaf+=1
}
}

if@hsp keyon&2{
if@hsp my>=0:my-=ido
}
if@hsp keyon&8{
if@hsp my<=410:my+=ido
}
if@hsp keyon&4{
if@hsp mx<=310:mx+=ido
if@hsp stage=2&mx<=310:mapx-=1
}
if@hsp keyon&1{
if@hsp mx>=0:mx-=ido
if@hsp stage=2&mx>=0:mapx+=1
}

if@hsp keyon&64{
if@hsp kasurikaunter>=500{
hissatuf=1
disbullet(10)		
ds_play 8
}
}
if@hsp keyon&128{
if@hsp kasurikaunter>=1500{
hissatuf=2
disbullet(10)		
ds_play 8
}
}


return@hsp
*write_status


font@hsp "MS ゴシック",16
color@hsp 255,255,255
line@hsp 350,0,350,440
pos@hsp 350,0:mes@hsp "Score"
pos@hsp 400,20:mes@hsp score
pos@hsp 355,40:mes@hsp "life"
pos@hsp 350,130:mes@hsp "ShotItem:"+shotpower

if@hsp shotpower\30=0&shotpower!0{
if@hsp shotpower>=120:ds_play 7:life+=1:shotpower=0

shotlv+=1
shotpower+=1
if@hsp shotlv>=3:shotlv=4
if@hsp shotlv<=3:dansu+=2:ds_play 7
}

pos@hsp 350,160:if@hsp shotlv<=2:mes@hsp "ShotLv:"+shotlv
if@hsp shotlv>=4:mes@hsp "Shotlv:MAX"
pos@hsp 355,200:mes@hsp "FPS="+fps
mes@hsp "wait="+waitkaunt
mes@hsp "object:"+sonzai
mes@hsp "kasuri="+kasurikaunter
mes@hsp "Frame="+frame
mes@hsp "平均FPS:"+(heikinfps/1000)
color@hsp 0,0,0
pos@hsp 0,0:mes@hsp "♪"+kyokumei
color@hsp 255,255,255
pos@hsp -1,-1:mes@hsp "♪"+kyokumei


color@hsp 255,255,255
if@hsp life<=0:return@hsp
if@hsp replayf=1:pos@hsp 355,60:mes@hsp "Replay Mode":return@hsp
repeat@hsp life
pos@hsp 355+5*cnt@hsp,60:mes@hsp "|"
loop@hsp

return@hsp
*write_mychar

if@hsp mutekif=0:gmode@hsp 2,40,30,
if@hsp mutekif=1:gmode@hsp 2,40,30,
if@hsp mutekif>=2{
if@hsp frame\5=1:gmode@hsp 5,,,200:else@hsp:gmode@hsp 2,40,30
mutekif+=1
if@hsp mutekif>=100:mutekif=0
}
pos@hsp mx,my:gcopy@hsp 3,0,0,40,30
gmode@hsp 2,10,17

pos@hsp mx+1,my+10:gcopy@hsp 3,jetx2,32,10,17
pos@hsp mx+25,my+10:gcopy@hsp 3,jetx2,32,10,17

if@hsp shotlv>3{
aktenz+=1.0
gmode@hsp 2,15,15
pos@hsp mx+60,my+15
grotate@hsp 5,17,103,aktenz,15,15
pos@hsp mx-20,my+15
grotate@hsp 5,17,103,aktenz,15,15
if@hsp utta3=1:uttakaunter3+=1
if@hsp uttakaunter3>=5:utta3=0:uttakaunter3=0

hassyaxoption=mx+60
hassyaxoption2=mx-20

repeat@hsp maxdansu
if@hsp shotdasuna=1:break@hsp
if@hsp utta3=1:break@hsp
if@hsp shotf.cnt@hsp>0 :continue@hsp									
hassyaxoption3=hassyaxoption
if@hsp frame\2=0:hassyaxoption3=hassyaxoption2

eh+
eh3.cnt@hsp=270
shotf.cnt@hsp=1												
shotx.cnt@hsp=(hassyaxoption3)*1000: shoty.cnt@hsp=(my+10)*1000		
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp			
shothitx=1
shothity=11
utta3=1
if@hsp eh=1 : eh=0 : break@hsp									

loop@hsp
}
if@hsp moretaspeed=5{
color@hsp 0,0,0

gmode@hsp 5,,,150
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-(my+20)+220,-(mx+30)+220,0,35-(frame\2*10)
d3particle 1,-(my+20)+220,-(mx+1)+220,0,35-(frame\2*10)
gmode@hsp 2,,
}


mycharcenterx=mx+18
mycharcentery=my+15

mycharuppery=2
mycharrightx=2

kasury=15
kasurx=20

return@hsp
*put_shot
if@hsp shotdasuna=1:return@hsp
if@hsp utta=1:uttakaunter+=1
if@hsp uttakaunter>=6:utta=0:uttakaunter=0
if@hsp utta=1:return@hsp


repeat@hsp dansu
gdansu=cnt@hsp

repeat@hsp maxdansu

if@hsp shotf.cnt@hsp>0 :continue@hsp									
eh+


if@hsp gdansu\2=0{
shotxmove=0
eh3.cnt@hsp=270-(gdansu/syatei)
}else@hsp{
shotxmove=10
eh3.cnt@hsp=270+(gdansu/syatei)
}

shotf.cnt@hsp=1												

shotx.cnt@hsp=(mx+14+shotxmove)*1000: shoty.cnt@hsp=my*1000		
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp			
if@hsp eh=1 : eh=0 : break@hsp									

loop@hsp

loop@hsp
shothitx=1
shothity=11
utta=1
return@hsp
*moreta_wapon
if@hsp kasurikaunter<500:hissatuf=0:return@hsp


shothitx=1
shothity=11

if@hsp waponx>=-400{
sparkan+=1
color@hsp 255,255,255
pos@hsp waponx,220
gmode@hsp 2,51,44
gcopy@hsp 3,90,48,51,44
pos@hsp waponx+60:font@hsp "MS　ゴシック",30
mes@hsp "もれ太スパーク！！"
waponx-=10
}
if@hsp sparkan=40{
repeat@hsp 2
wcnt=cnt@hsp
repeat@hsp maxdansu

if@hsp shotf.cnt@hsp>0 :continue@hsp									
eh+
if@hsp wcnt=0:rand=0
if@hsp wcnt=1:rand=180
eh3.cnt@hsp=rand
shotf.cnt@hsp=2												
shotx.cnt@hsp=(mx+14+shotxmove)*1000: shoty.cnt@hsp=my*1000		
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp			
shothitx=1
shothity=11
if@hsp eh=1 : eh=0 : break@hsp									

loop@hsp
loop@hsp

sparkan=0
}
if@hsp waponx<=0:waponx=440:hissatuf=0:kasurikaunter-=500
shothitx=1
shothity=11
return@hsp
*moreta_wapon2
if@hsp kasurikaunter<1500:hissatuf=0:return@hsp

if@hsp shotdasuna!1 & sens=0:disbullet(10)


if@hsp waponx2>=-400{
endakan+=1
morerl=1
color@hsp 255,255,255
pos@hsp waponx2,220
gmode@hsp 2,51,44
gcopy@hsp 3,90,48,51,44
pos@hsp waponx2+60:font@hsp "MS　ゴシック",30
mes@hsp "パーフェクト・モレール!"
waponx2-=10


}
if@hsp waponx2<=0:waponx2=440:hissatuf=0:kasurikaunter-=1500

if@hsp endakan=40{

if@hsp dansu!60:motodansu=dansu
dansu=60
endakan=0

}


return@hsp
*moreta_wapon2_2
wapon2kaun+=1
if@hsp wapon2kaun>=600:dansu=motodansu:wapon2kaun=0:morerl=0
if@hsp shotdasuna!1&sens=0:disbullet(10)		

return@hsp
*call_enemy

notesel@hsp enemyline.turn
noteget@hsp enemyname,0


if@hsp ( enemyname = "sleep" ) : gosub@hsp *sleeping
if@hsp ( enemyname = "kaiwa1" ) : gosub@hsp *k1
if@hsp ( enemyname = "kaiwa2" ) : gosub@hsp *k2
if@hsp enemyname="kaiwa3":gosub@hsp *k3
if@hsp enemyname="kaiwa4":gosub@hsp *k4
if@hsp enemyname="kaiwa5":gosub@hsp *k5
if@hsp enemyname="kaiwa6":gosub@hsp *k6
if@hsp enemyname="kaiwa7":gosub@hsp *k7
if@hsp enemyname="kaiwa8":gosub@hsp *k8
if@hsp enemyname="kaiwa9":gosub@hsp *k9
if@hsp enemyname="kaiwa10":gosub@hsp *k10
if@hsp enemyname="kaiwa11":gosub@hsp *k11
if@hsp enemyname="kaiwa12":gosub@hsp *k12
if@hsp enemyname="kaiwa13":gosub@hsp *k13
if@hsp enemyname="kaiwa14":gosub@hsp *k14
if@hsp enemyname="kaiwa15":gosub@hsp *k15
if@hsp enemyname="kaiwa16":gosub@hsp *k16
if@hsp enemyname="kaiwa17":gosub@hsp *k17
if@hsp enemyname="kaiwa18":gosub@hsp *k18
if@hsp enemyname="kaiwa19":gosub@hsp *k19
if@hsp enemyname="kaiwa20":gosub@hsp *k20
if@hsp enemyname="cla1":gosub@hsp *stagecla1
if@hsp enemyname="cla2":gosub@hsp *stagecla2
if@hsp enemyname="cla3":gosub@hsp *stagecla3
if@hsp enemyname="stop":gosub@hsp *teisi
if@hsp enemyname="stop2":gosub@hsp *teisi2
if@hsp enemyname="enemy1":gosub@hsp *put_enemy1
if@hsp enemyname="enemy2":gosub@hsp *put_enemy2
if@hsp enemyname="enemy3":gosub@hsp *put_enemy3
if@hsp enemyname="enemy4":gosub@hsp *put_enemy4
if@hsp enemyname="enemy5":gosub@hsp *put_enemy5
if@hsp enemyname="enemy6":gosub@hsp *put_enemy6
if@hsp enemyname="enemy7":gosub@hsp *put_enemy7
if@hsp enemyname="enemy8":gosub@hsp *put_enemy8
if@hsp enemyname="enemy9":gosub@hsp *put_enemy9
if@hsp enemyname="enemy10":gosub@hsp *put_enemy10
if@hsp enemyname="enemy11":gosub@hsp *put_enemy11
if@hsp enemyname="enemy12":gosub@hsp *put_enemy12
if@hsp enemyname="enemy13":gosub@hsp *put_enemy13
if@hsp enemyname="enemy14":gosub@hsp *put_enemy14
if@hsp enemyname="enemy15":gosub@hsp *put_enemy15
if@hsp enemyname="midle1":gosub@hsp *midle1
if@hsp enemyname="boss1":gosub@hsp *boss1
if@hsp enemyname="boss2":gosub@hsp *boss2
if@hsp enemyname="fannel":gosub@hsp *fanel
if@hsp enemyname="midle2":gosub@hsp *midle2
if@hsp enemyname="midle3":gosub@hsp *midle3
if@hsp enemyname="gochain":gosub@hsp *chainput

if@hsp enemyname="uty":gosub@hsp *utyusenhail
if@hsp enemyname="chain":gosub@hsp *chain

if@hsp( enemyname = "sen1" ): gosub@hsp *sen1
if@hsp( enemyname = "sen2" ): gosub@hsp *sen2
if@hsp( enemyname = "vman3"): gosub@hsp *vman3
if@hsp( enemyname = "cannon"):cannon = 1 : turn += 1 :mmstop@hsp

if@hsp enemyname="toil":gosub@hsp *toila

return@hsp
*toila
noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=60										

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=0 : tyv.cnt@hsp=0	


hitchklenghx.cnt@hsp=23
hitchklenghy.cnt@hsp=23


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*chain
turn+=1
chainf=1
stage=4
return@hsp

*k1
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{
pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\nわが軍の領内にUNKNOWN機が進入！"
}
kaiwakaunter+=10
}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
mes@hsp "通信士\n\n機体確認信号に答えません！\n隊長！どうしますか！？"

}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\n全員、攻撃の用意!\n\n抵抗した場合は撃墜してもかまわん！"

}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nトイレは何処だろうかナァ。"

}
if@hsp kaiwaf=5{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,310:gmode@hsp 2,,,
gcopy@hsp 3,90,48,51,44

pos@hsp 100,310
mes@hsp "もれ太\n\nくそ、銃のトリガーがこわれてて\nたれ流しだ。"

}
if@hsp kaiwaf=6{
kaiwaf=0
turn+=1
kaiwakaunter=0
}

return@hsp
*k2
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\n防衛線を突破されました！"
}
kaiwakaunter+=10
dmstop 4
}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nなんという強さだ・・。\n試作機だが、'NOSTRA'を出動させろ！"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nしかし、奴の目的は\n何なんだ・・・？"

}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nうートイレトイレ。"

}

if@hsp kaiwaf=5{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmplay 0,2
kyokumei="El Cumbanchero"
}

return@hsp
*k3
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,82,123,80,99


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "隊長\n\nまだまだ！ﾌｧﾝﾈﾙがのこっている！"
}
kaiwakaunter+=10
}

if@hsp kaiwaf=2{
kaiwaf=0
turn+=1
kaiwakaunter=0
gook=1
}

return@hsp
*k4
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\n全機撃墜されました！"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nな、なんだってーーーーーーー！！！"


}
if@hsp kaiwaf=3{
dmstop
ds_play 9
kaiwaf=0
turn+=1
kaiwakaunter=0
}

return@hsp
*k5
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\n生物研究所へ向かってる模様です！"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nそうか・・\nだがあそこには\nスーパーモスキートが\n放ってある\n"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\n生きて抜けることはできまい・・・。"


}
if@hsp kaiwaf=4{
kaiwaf=0
turn+=1
kaiwakaunter=0
}

return@hsp
*k6
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 5,37,29,26,33


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "Ｖマン\n\nまてーい！"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nな、なんだ！？！？"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121


gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 5,37,29,26,33

pos@hsp 100,310
mes@hsp "Vマン\n\n俺が倒せるかな？\n倒せたらトイレに案内してやるよ"


}
if@hsp kaiwaf=4{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop
mmplay@hsp 12
kyokumei="Cipple Cleek"
}

return@hsp
*k7
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 5,37,29,26,33


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "Ｖマン\n\nすまん、急用ができた"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nてめええええええ\nふざけんなぁあああ！\nあああああああ！"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121


gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 5,37,29,26,33

pos@hsp 100,310
mes@hsp "Vマン\n\nシャバ憎には付き合ってられんわ。"


}
if@hsp kaiwaf=4{
kaiwaf=0
turn+=1
kaiwakaunter=0
mmstop@hsp
dmplay 0, 6
kyokumei="Jerusalem Ridge"
}

return@hsp
*k8
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\nもうこうなったら、\nアレしかありませんね・・・"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nうむ・・\n生物兵器、[NEO-TENY]をだせ！！"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\n貴様もネオテニーにしてやる！！"


}

if@hsp kaiwaf=4{
kaiwaf=0
turn+=1
kaiwakaunter=0

mmstop@hsp
kyokumei="Katy Hill"

}

return@hsp
*k9
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
mes@hsp "通信士\n\nあ・・・・・\nこれは・・・"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
mes@hsp "隊長\n\nもういいよ！！\n帰る！！！！"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
mes@hsp "通信士\n\n・・・・"


}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nだめだ・・・\nもう地球にトイレはない。"
}
if@hsp kaiwaf=5{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
mes@hsp "もれ太\n\nそうだ・・・\n宇宙にいこう・・・。"
}
if@hsp kaiwaf=6{
kaiwaf=0
turn+=1
kaiwakaunter=0


}

return@hsp
*k10
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nついにわれわれの\n宇宙ステーションまで\nやってくるぞ！！"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\n総員出撃！！なんとしても食い止めろ！！"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\nなーんかもうだるくなってきた\nなあ・・"


}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "もれ太\n\nトイレが・・近づいている・・！！"
}

if@hsp kaiwaf=5{
kaiwaf=0
turn+=1
kaiwakaunter=0


}

return@hsp
*k11
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 5,37,29,26,33


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Ｖマン\n\nハッハッハ。まっていたよ\nヤマトの諸君"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "もれ太\n\nき、きさま！"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121


gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 5,37,29,26,33

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Vマン\n\nこないだはちょっと用事を思い出したが\n次はそうはいかないぜ"


}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310:color@hsp 255,255,255
mes@hsp "もれ太\n\n勝ったらトイレに案内してもらうぞ！"


}
if@hsp kaiwaf=5{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121


gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 5,37,29,26,33

pos@hsp 100,310:color@hsp 255,255,255
mes@hsp "Vマン\n\nオッケーイ。"


}
if@hsp kaiwaf=6{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop:mmstop@hsp
mmplay@hsp 14
vman2f=1
kyokumei="Cripple Cleek 2"
}
return@hsp
*k12
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 5,37,29,26,33


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Ｖマン\n\nやべえ！お布団ほしたまんま\nだった！！"

}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "もれ太\n\nちょっ！トイレは！？！？"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121


gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 5,37,29,26,33

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Vマン\n\nじゃっ！またな！"


}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310:color@hsp 255,255,255
font@hsp "MS ゴシック",30
mes@hsp "あいつを\n\nぜってーぶっころす"


}

if@hsp kaiwaf=5{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop:mmstop@hsp:mmplay@hsp 15

kyokumei="Orange Blossom Special Arrange"
}
return@hsp
*k13
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nチェインガードを起動させる！\n通路をふさげ！！"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\nでもアレはまだ十分なテストも\nとれてませんが・・"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nいっけええええええええええ\nおらああああああ"



}

if@hsp kaiwaf=4{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop:mmstop@hsp
dmplay 0,10
kyokumei="Done_Gone"
}
return@hsp
*k14
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\nあーあやっちゃった・・。"
}
kaiwakaunter+=10
}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nいやほら・・耐久テストしてないなんて・・\nおもわなかったんだ。。"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nこうなったらやけだ！！！おら！\nチェインガード全機\n投入！！！！"



}
if@hsp kaiwaf=4{
kaiwaf=0
turn+=1
kaiwakaunter=0
}
return@hsp
*k15
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\nかかった予算１８億ホンコンドルが\n全部パーか・・。"
}
kaiwakaunter+=10

}
if@hsp kaiwaf=2{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop
ds_play 9
stage=3
utyusz2=0
utyusz=0
kyokumei="Orange Blossom Special Arrange"
}
return@hsp
*k16
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\nこのままだと内部コアの\n脆弱性を突かれて基地ごと\nドカンといきます！"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\n最終手段だ。\n某国から仕入れた最強のロボット・・\n出動させるぞ。"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\nいまどきアレかよ・・・"


}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nそういうな、まだコアなファンはいる。"


}

if@hsp kaiwaf=5{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop
mmstop@hsp:dmplay 100,11
stage=3:shotdasuna=1

kyokumei="Black Berry Blossom AzmaSpecial"
}
return@hsp
*k17
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 5,37,29,26,33


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Ｖマン\n\nちょっと待った！！"
}
kaiwakaunter+=10

}



if@hsp kaiwaf=2{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop
mmstop@hsp:mmplay@hsp 2


kyokumei="A-10"
}
return@hsp
*k18
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 5,37,29,26,33


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Ｖマン\n\nもれ太！こいつは強いぞ！\nここは俺に任せて\nトイレに行くんだ！"
}
kaiwakaunter+=10

}
if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "もれ太\n\nＶマン！？"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121


gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 5,37,29,26,33

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Vマン\n\nトイレへ案内すると・・\n約束したからな・・"


}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310:color@hsp 255,255,255
mes@hsp "もれ太\n\nＶマン・・・・\nおまえってやつは・・・!"


}

if@hsp kaiwaf=5{
kaiwaf=0
turn+=1
kaiwakaunter=0
mutekif=0

kyokumei="A-10"
}
return@hsp
*k19
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 5,37,29,26,33


if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "Ｖマン\n\nウッ"
}
kaiwakaunter+=10

}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 2,,,
pos@hsp 10,310
gcopy@hsp 3,90,48,51,44


pos@hsp 100,310:color@hsp 255,255,255
font@hsp "MS ゴシック",24
mes@hsp "もれ太\n\n期待した俺が\nバカだった"


}

if@hsp kaiwaf=3{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop
mmstop@hsp
shotdasuna=0
cannon = 5


kyokumei="Black Berry Blossom AzmaSpecial"
}
return@hsp
*k20
if@hsp kaiwaf=0:kaiwaf=1

if@hsp kaiwaf=1{

pos@hsp 0,440-kaiwakaunter:gmode@hsp 4,,,200
if@hsp kaiwakaunter>=140:pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

pos@hsp 10,450-kaiwakaunter:gmode@hsp 1,,,
if@hsp kaiwakaunter>=140:pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

if@hsp kaiwakaunter>=140{
pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\n内燃機関がメルトダウンしています！\n暴走しますよ！"
}
kaiwakaunter+=10
}

if@hsp kaiwaf=2{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nこのままでは宇宙ステーションもろとも\n吹き飛んでしまう・・"


}
if@hsp kaiwaf=3{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\n隊長！どうするんですか！"


}
if@hsp kaiwaf=4{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\n・・・・・"



}
if@hsp kaiwaf=5{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,0,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "通信士\n\n隊長！"

}
if@hsp kaiwaf=6{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\n俺にだって・・・"



}
if@hsp kaiwaf=7{
gmode@hsp 4,,,200
pos@hsp 0,300
gcopy@hsp 8,0,0,369,121

gmode@hsp 1,,,
pos@hsp 10,310
gcopy@hsp 8,82,123,80,99

pos@hsp 100,310
color@hsp 255,255,255
mes@hsp "隊長\n\nわからないことぐらい・・・\nある・・"



}
if@hsp kaiwaf=8{
kaiwaf=0
turn+=1
kaiwakaunter=0
dmstop:mmstop@hsp
dmplay 100,15
}
return@hsp
*utyusenhail
utyusenf=1:utyusy=-440:utyusy2=-440:tiky=0
turn+=1
return@hsp
*put_enemy1

noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=1										

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*sight

getsankaktcy target
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=b										
tf.cnt@hsp=1										
modc=double@hsp((eh2.cnt@hsp+290)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc

ts.cnt@hsp=41										

tx.cnt@hsp=(tcx.target+3)*1000 :ty.cnt@hsp=(tcy.target+30)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2	


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*fanel

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp fahp,3
fhp=int@hsp(fahp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
fhp.cnt@hsp=fhp
eh+
eh2.cnt@hsp=0										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=14										

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10	


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=2


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy2
noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=89										
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=5

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*put_enemy3
noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=180										

tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=9

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*put_enemy5
noteget@hsp exa,1
noteget@hsp eya,2




repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+

tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=17

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
eh2.cnt@hsp=180
txv.cnt@hsp=cosa(eh2.cnt@hsp)/1 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/1	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*put_enemy4
noteget@hsp exa,1
noteget@hsp eya,2



if@hsp deta=0:mmplay@hsp 11:deta=1
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+

tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=16

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
getsankak3 cnt@hsp : eh2.cnt@hsp=b							
txv.cnt@hsp=cosa(eh2.cnt@hsp)/1 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/1	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*put_enemy6
noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=0										

tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=22

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*put_enemy7
noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=89										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

zhp.cnt@hsp=zhptmp
ts.cnt@hsp=23

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1	
return@hsp
*put_enemy8

noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=1										

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy9

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=31										
zhp.cnt@hsp=zhptmp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy10

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=32										
zhp.cnt@hsp=zhptmp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy12

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=34										
zhp.cnt@hsp=zhptmp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy11

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=33										
zhp.cnt@hsp=zhptmp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy13

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=36										
zhp.cnt@hsp=zhptmp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp

*put_enemy14

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=38										
zhp.cnt@hsp=zhptmp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=13
hitchklenghy.cnt@hsp=13


tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_enemy15

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp zhptmp,3
zhptmp=int@hsp(zhptmp)



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=40										
zhp.cnt@hsp=zhptmp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=32
hitchklenghy.cnt@hsp=32


tcplusx.cnt@hsp=32
tcplusy.cnt@hsp=32

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*midle1

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp chp,3
chp=int@hsp(chp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=125											
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=6

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10			


hitchklenghx.cnt@hsp=32
hitchklenghy.cnt@hsp=32


tcplusx.cnt@hsp=32
tcplusy.cnt@hsp=32

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*midle2

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp chp,3
chp=int@hsp(chp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=125											
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=18

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3			


hitchklenghx.cnt@hsp=12
hitchklenghy.cnt@hsp=12



tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*midle3

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp chp,3
chp=int@hsp(chp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=89											
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=39

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3			


hitchklenghx.cnt@hsp=12
hitchklenghy.cnt@hsp=12



tcplusx.cnt@hsp=12
tcplusy.cnt@hsp=12

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*chainput

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp dhp,3
bhp=int@hsp(dhp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} 		if@hsp dis.cnt@hsp>0 {continue@hsp}					
eh+
eh2.cnt@hsp=90											
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=44
zhp.cnt@hsp=bhp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=0 : tyv.cnt@hsp=0			


hitchklenghx.cnt@hsp=100
hitchklenghy.cnt@hsp=60


tcplusx.cnt@hsp=100
tcplusy.cnt@hsp=60

hontai=cnt@hsp

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} 	if@hsp dis.cnt@hsp>0 {continue@hsp}						
eh+
eh2.cnt@hsp=300											
tf.cnt@hsp=1										
tc.cnt@hsp=hontai										
ts.cnt@hsp=45
zhp.cnt@hsp=bhp

tx.cnt@hsp=(int@hsp(exa)+145)*1000 :ty.cnt@hsp=(int@hsp(eya)-8)*1000		
txv.cnt@hsp=0 : tyv.cnt@hsp=0			


hitchklenghx.cnt@hsp=40
hitchklenghy.cnt@hsp=5


tcplusx.cnt@hsp=80
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} 		if@hsp dis.cnt@hsp>0 {continue@hsp}					
eh+
eh2.cnt@hsp=200											
tf.cnt@hsp=1										
tc.cnt@hsp=hontai										
ts.cnt@hsp=46
zhp.cnt@hsp=bhp

tx.cnt@hsp=(int@hsp(exa)-20)*1000 :ty.cnt@hsp=int@hsp(eya+10)*1000		
txv.cnt@hsp=0 : tyv.cnt@hsp=0			

hitchklenghx.cnt@hsp=50
hitchklenghy.cnt@hsp=5


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} 	if@hsp dis.cnt@hsp>0 {continue@hsp}					
eh+
eh2.cnt@hsp=125											
tf.cnt@hsp=1										
tc.cnt@hsp=hontai										
ts.cnt@hsp=47
zhp.cnt@hsp=bhp

tx.cnt@hsp=(int@hsp(exa)+145)*1000 :ty.cnt@hsp=int@hsp(eya+100)*1000		
txv.cnt@hsp=0 : tyv.cnt@hsp=0			


hitchklenghx.cnt@hsp=40
hitchklenghy.cnt@hsp=5


tcplusx.cnt@hsp=80
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp}	if@hsp dis.cnt@hsp>0 {continue@hsp}					
eh+
eh2.cnt@hsp=45											
tf.cnt@hsp=1										
tc.cnt@hsp=hontai										
ts.cnt@hsp=48
zhp.cnt@hsp=bhp

tx.cnt@hsp=(int@hsp(exa)-20)*1000 :ty.cnt@hsp=int@hsp(eya+115)*1000		
txv.cnt@hsp=0 : tyv.cnt@hsp=0			


hitchklenghx.cnt@hsp=50
hitchklenghy.cnt@hsp=5


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp
turn+=1

return@hsp
*boss1

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp dhp,3
bhp=int@hsp(dhp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90											
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=12
zhp.cnt@hsp=bhp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10			


hitchklenghx.cnt@hsp=64
hitchklenghy.cnt@hsp=32


tcplusx.cnt@hsp=60
tcplusy.cnt@hsp=32

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*boss2

noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp dhp,3
bhp=int@hsp(dhp)


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=0										
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=25
zhp.cnt@hsp=bhp

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10			


hitchklenghx.cnt@hsp=15
hitchklenghy.cnt@hsp=32


tcplusx.cnt@hsp=25
tcplusy.cnt@hsp=40

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*put_item


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=270 
tf.cnt@hsp=1										
ts.cnt@hsp=4


hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9

tc.cnt@hsp=255											
tx.cnt@hsp=(tx2.target+9)*1000 :ty.cnt@hsp=ty2.target*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	
if@hsp eh=1 : eh=0 : break@hsp								
loop@hsp

return@hsp
*put_item2


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=270 
tf.cnt@hsp=1										
ts.cnt@hsp=21


hitchklenghx.cnt@hsp=32
hitchklenghy.cnt@hsp=27


tcplusx.cnt@hsp=16
tcplusy.cnt@hsp=13

tc.cnt@hsp=255											
tx.cnt@hsp=(tx2.target+9)*1000 :ty.cnt@hsp=ty2.target*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/8 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/8	
if@hsp eh=1 : eh=0 : break@hsp								
loop@hsp

return@hsp
*put_enemyshot1

if@hsp mutekif>=1:return@hsp

getsankak target

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
if@hsp b-2<0:b+360
eh2.cnt@hsp=b-2

tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=2										
if@hsp type=2:ts.cnt@hsp=27

tx.cnt@hsp=tx2.target*1000 :ty.cnt@hsp=ty2.target*1000		
if@hsp type=2:tx.cnt@hsp=tcx.target*1000 :ty.cnt@hsp=tcy.target*1000

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	

txv.cnt@hsp=cosa(eh2.cnt@hsp)/5
tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	
if@hsp type=2{
txv.cnt@hsp=cosa(eh2.cnt@hsp)/spd
tyv.cnt@hsp=sina(eh2.cnt@hsp)/spd	
}


hitchklenghx.cnt@hsp=2
hitchklenghy.cnt@hsp=2


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2
if@hsp type=2{

hitchklenghx.cnt@hsp=10
hitchklenghy.cnt@hsp=10


tcplusx.cnt@hsp=10
tcplusy.cnt@hsp=10
}

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

return@hsp
*houtyou

if@hsp mutekif>=1:return@hsp


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90									
tf.cnt@hsp=1										
tc.cnt@hsp=255										
ts.cnt@hsp=19										
tk.cnt@hsp=double@hsp(2.0*3.1415926535897932384626433832795)

tx.cnt@hsp=tx2.target*1000 :ty.cnt@hsp=ty2.target*1000		
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2
tyv.cnt@hsp=sina(eh2.cnt@hsp)/2	


hitchklenghx.cnt@hsp=5
hitchklenghy.cnt@hsp=5


tcplusx.cnt@hsp=-2
tcplusy.cnt@hsp=5

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

return@hsp
*houtyou2

if@hsp mutekif>=1:return@hsp

getsankak target
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=b									
tf.cnt@hsp=1										
tc.cnt@hsp=11										
ts.cnt@hsp=19										
modc=double@hsp((eh2.cnt@hsp+290)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc

tx.cnt@hsp=tx2.target*1000 :ty.cnt@hsp=ty2.target*1000		

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	

txv.cnt@hsp=cosa(eh2.cnt@hsp)/2
tyv.cnt@hsp=sina(eh2.cnt@hsp)/2	


hitchklenghx.cnt@hsp=4
hitchklenghy.cnt@hsp=5


tcplusx.cnt@hsp=-2
tcplusy.cnt@hsp=3

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

return@hsp
*houtyou3

if@hsp mutekif>=1:return@hsp

getsankak target
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
if@hsp eh\2=0:maikai=-1:else@hsp:maikai=1

eh2.cnt@hsp=b+((eh-1)*5*(maikai)) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360

tf.cnt@hsp=1										
tc.cnt@hsp=11										
ts.cnt@hsp=19										
modc=double@hsp((eh2.cnt@hsp+290)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc

tx.cnt@hsp=tx2.target*1000 :ty.cnt@hsp=ty2.target*1000		

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	

txv.cnt@hsp=cosa(eh2.cnt@hsp)/2
tyv.cnt@hsp=sina(eh2.cnt@hsp)/2	


hitchklenghx.cnt@hsp=2
hitchklenghy.cnt@hsp=2


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=3

if@hsp eh=10 : eh=0 : break@hsp							
loop@hsp

return@hsp
*laser_ramon1


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=mukaukakudo									
tf.cnt@hsp=1										
modc=double@hsp((eh2.cnt@hsp+287)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc
ts.cnt@hsp=37										
if@hsp mode=1:ts.cnt@hsp=42


tx.cnt@hsp=(tcx.target+3)*1000 :ty.cnt@hsp=(tcy.target+14)*1000		


txv.cnt@hsp=0
tyv.cnt@hsp=0	


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0



if@hsp ts.target=50{
if@hsp eh=1 : eh=0  :break@hsp
}else@hsp{
if@hsp eh=1 : eh=0  :ds_play 11:break@hsp							
}

loop@hsp

return@hsp
*laser_ramon2


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=mukaukakudo									
tf.cnt@hsp=1										
modc=double@hsp((eh2.cnt@hsp+287)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc
hm.cnt@hsp=target			

ts.cnt@hsp=42

tx.cnt@hsp=(tcx.target+3)*1000 :ty.cnt@hsp=(tcy.target+14)*1000		

txv.cnt@hsp=cosa(eh2.cnt@hsp)/spd
tyv.cnt@hsp=sina(eh2.cnt@hsp)/spd	


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0  :ds_play 11:break@hsp							
loop@hsp

return@hsp
*laser_ramon3



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=mukaukakudo									
tf.cnt@hsp=1										
modc=double@hsp((eh2.cnt@hsp+287)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc

ts.cnt@hsp=43

tx.cnt@hsp=(tcx.target+3)*1000 :ty.cnt@hsp=(tcy.target+14)*1000		


if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	


txv.cnt@hsp=cosa(eh2.cnt@hsp)/spd
tyv.cnt@hsp=sina(eh2.cnt@hsp)/spd	


hitchklenghx.cnt@hsp=8
hitchklenghy.cnt@hsp=8


tcplusx.cnt@hsp=-2
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0  :break@hsp							
loop@hsp

return@hsp
*c_cannon


repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=mukaukakudo									
tf.cnt@hsp=1										
modc=double@hsp((eh2.cnt@hsp+287)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc
ts.cnt@hsp=37										
if@hsp mode=1:ts.cnt@hsp=42

tx.cnt@hsp=(tcx.target+3)*1000 :ty.cnt@hsp=(tcy.target+14)*1000		

txv.cnt@hsp=0
tyv.cnt@hsp=0	


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0  :ds_play 11:break@hsp							
loop@hsp

return@hsp
*laser

if@hsp mutekif>=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
if@hsp eh=1:eh2.cnt@hsp=300
if@hsp eh=2:eh2.cnt@hsp=320
if@hsp eh=3:eh2.cnt@hsp=340
if@hsp eh=4:eh2.cnt@hsp=240
if@hsp eh=5:eh2.cnt@hsp=220
if@hsp eh=6:eh2.cnt@hsp=200
tf.cnt@hsp=1										
tc.cnt@hsp=target										
ts.cnt@hsp=20										

tx.cnt@hsp=tx2.target*1000 :ty.cnt@hsp=ty2.target*1000		
if@hsp ts.target=44:tx.cnt@hsp=tcx.target*1000 :ty.cnt@hsp=tcy.target*1000		
if@hsp ts.target=50:tx.cnt@hsp=tcx.target*1000 :ty.cnt@hsp=tcy.target*1000		

txv.cnt@hsp=cosa(eh2.cnt@hsp)/5
tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=1
hitchklenghy.cnt@hsp=1

tcplusx.cnt@hsp=1
tcplusy.cnt@hsp=1

if@hsp eh=6 : eh=0 : break@hsp							
loop@hsp

return@hsp

*endanmak

if@hsp mutekif>=1:return@hsp

getsankak target

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=(eh-1)*10+(pt*5) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=2
if@hsp type=6:ts.cnt@hsp=26

tc.cnt@hsp=255										
tx.cnt@hsp=(tx2.target+8)*1000 :ty.cnt@hsp=(ty2.target-3)*1000	

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	


txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5			

if@hsp ts.target=12:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	
if@hsp ts.target=25:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=36 : eh=0 : break@hsp							
loop@hsp

return@hsp
*neraiendanmak

if@hsp mutekif>=1:return@hsp

getsankak target

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=b+6+(eh-1)*10 : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=24

tc.cnt@hsp=255										
tx.cnt@hsp=(tx2.target+8)*1000 :ty.cnt@hsp=(ty2.target-3)*1000	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3			


if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	



if@hsp ts.target=12:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	
if@hsp ts.target=25:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=36 : eh=0 : break@hsp							
loop@hsp

return@hsp
*danmak2

if@hsp mutekif>=1:return@hsp

getsankak target

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
if@hsp eh\2=0:maikai=-1:else@hsp:maikai=1

eh2.cnt@hsp=b-2+(eh*5*(maikai)) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
tf.cnt@hsp=1										
ts.cnt@hsp=7

tc.cnt@hsp=255										
tx.cnt@hsp=(tx2.target+8)*1000 :ty.cnt@hsp=(ty2.target-3)*1000	

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	


txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5			


if@hsp ts.target=6{
tx.cnt@hsp=(tcx.target-14)*1000 :ty.cnt@hsp=tcy.target*1000
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3:tyv.cnt@hsp=sina(eh2.cnt@hsp)/3
}
if@hsp ts.target=12{
tx.cnt@hsp=(tcx.target-5)*1000 :ty.cnt@hsp=(tcy.target)*1000
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5:tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
}


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=6 : eh=0 : break@hsp							
loop@hsp

return@hsp
*danmak3

if@hsp mutekif>=1:return@hsp

getsankak target

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
if@hsp eh\2=0:maikai=-1:else@hsp:maikai=1

eh2.cnt@hsp=b-2+(eh*5*(maikai)) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
tf.cnt@hsp=1										
ts.cnt@hsp=10

tc.cnt@hsp=255										
tx.cnt@hsp=(tx2.target+8)*1000 :ty.cnt@hsp=(ty2.target-3)*1000	

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	


txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3			

if@hsp ts.target=12{
tx.cnt@hsp=(tcx.target-14)*1000 :ty.cnt@hsp=(tcy.target+10)*1000
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3:tyv.cnt@hsp=sina(eh2.cnt@hsp)/3
}
if@hsp ts.target=31{

txv.cnt@hsp=cosa(eh2.cnt@hsp)/2:tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=3 : eh=0 : break@hsp							
loop@hsp

return@hsp
*danmak4

if@hsp mutekif>=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
if@hsp eh\2=0:maikai=-1:else@hsp:maikai=1

eh2.cnt@hsp=0
tf.cnt@hsp=1										
ts.cnt@hsp=13

tc.cnt@hsp=255										
if@hsp ts.target!14{
if@hsp eh=1:	tx.cnt@hsp=(tcx.target+52)*1000	:	ty.cnt@hsp=(tcy.target-15)*1000
if@hsp eh=2:	tx.cnt@hsp=(tcx.target-57)*1000	:	ty.cnt@hsp=(tcy.target-15)*1000
if@hsp eh=3:	tx.cnt@hsp=(tcx.target+50)*1000	:	ty.cnt@hsp=(tcy.target-30)*1000
if@hsp eh=4:	tx.cnt@hsp=(tcx.target-55)*1000	:	ty.cnt@hsp=(tcy.target-30)*1000
if@hsp eh=5:	tx.cnt@hsp=(tcx.target+50)*1000	:	ty.cnt@hsp=(tcy.target+7)*1000
if@hsp eh=6:	tx.cnt@hsp=(tcx.target-55)*1000	:	ty.cnt@hsp=(tcy.target+7)*1000
}
if@hsp ts.target=14:tx.cnt@hsp=(tcx.target-10)*1000	:	ty.cnt@hsp=(tcy.target)*1000

txv.cnt@hsp=0 : tyv.cnt@hsp=0			


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp ts.target=14{
if@hsp eh=1: eh=0 : break@hsp
}

if@hsp eh=6 : eh=0 : break@hsp							
loop@hsp

return@hsp
*uzudanmak
if@hsp mutekif=1:return@hsp
getsankaktcy target
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
tf.cnt@hsp=1										
ts.cnt@hsp=10
if@hsp type=0:ts.cnt@hsp=10
if@hsp type=4:ts.cnt@hsp=24
if@hsp type=1:ts.cnt@hsp=7
if@hsp type=2:ts.cnt@hsp=10
if@hsp type=3:ts.cnt@hsp=7
if@hsp type=5:ts.cnt@hsp=7
if@hsp type=6:ts.cnt@hsp=26
if@hsp type=7:ts.cnt@hsp=10
if@hsp type=8:tx.cnt@hsp=7
if@hsp type=9:ts.cnt@hsp=56
tc.cnt@hsp=255										
if@hsp type=0:eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=4:eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=1:eh2.cnt@hsp=(eh-1)*60+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=2:eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359  : eh2.cnt@hsp-=360
if@hsp type=3:eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=5:eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=6:eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=7:eh2.cnt@hsp=60+(frame\2*5)+(eh-1)*5				: if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=8:eh2.cnt@hsp=(eh-1)*10+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp type=9:eh2.cnt@hsp=(eh-1)*30+(frame\60) : if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000
if@hsp ts.target=12:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	
if@hsp ts.target=18:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000		
if@hsp ts.target=44:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000		
if@hsp type=5:tx.cnt@hsp=(tcx.target+20)*1000 :ty.cnt@hsp=(tcy.target-20)*1000

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	
txv.cnt@hsp=cosa(eh2.cnt@hsp)/spd : tyv.cnt@hsp=sina(eh2.cnt@hsp)/spd


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=12 : eh=0 : break@hsp							
loop@hsp

return@hsp
*gyakuuzudanmak
if@hsp mutekif=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
tf.cnt@hsp=1										
ts.cnt@hsp=10
if@hsp type=0:ts.cnt@hsp=10
if@hsp type=4:ts.cnt@hsp=24
if@hsp type=1:ts.cnt@hsp=7
if@hsp type=2:ts.cnt@hsp=10
if@hsp type=3:ts.cnt@hsp=7
if@hsp type=5:ts.cnt@hsp=10
if@hsp type=8:ts.cnt@hsp=10

tc.cnt@hsp=255										
if@hsp type=0:eh2.cnt@hsp=(eh-1)*-30-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
if@hsp type=4:eh2.cnt@hsp=(eh-1)*-30-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
if@hsp type=1:eh2.cnt@hsp=(eh-1)*-60-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
if@hsp type=2:eh2.cnt@hsp=(eh-1)*-30-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
if@hsp type=3:eh2.cnt@hsp=(eh-1)*-30-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
if@hsp type=5:eh2.cnt@hsp=(eh-1)*-30-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
if@hsp type=8:eh2.cnt@hsp=(eh-1)*-10-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
if@hsp type=9:eh2.cnt@hsp=(eh-1)*-10-(frame\60) : if@hsp eh2.cnt@hsp<0 : eh2.cnt@hsp+=360:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp+=360
tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000
if@hsp ts.target=12:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	
if@hsp ts.target=18:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000		
if@hsp type=5:tx.cnt@hsp=(tcx.target-20)*1000 :ty.cnt@hsp=(tcy.target-25)*1000

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	

txv.cnt@hsp=cosa(eh2.cnt@hsp)/spd : tyv.cnt@hsp=sina(eh2.cnt@hsp)/spd


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=12 : eh=0 : break@hsp							
loop@hsp

return@hsp
*uzudanmak2
if@hsp mutekif=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
tf.cnt@hsp=1										
ts.cnt@hsp=10
if@hsp type=0:ts.cnt@hsp=10
if@hsp type=1:ts.cnt@hsp=7	
tc.cnt@hsp=255										
if@hsp type=0{
eh2.cnt@hsp=45+(eh*10):if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp eh2.cnt@hsp<=0:eh2.cnt@hsp=350
if@hsp eh\2=0:spd+=1
}
if@hsp type=1{
eh2.cnt@hsp=125-(eh*10):if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp-=360
if@hsp eh2.cnt@hsp<=0:eh2.cnt@hsp=350
if@hsp eh\2=0:spd+=1
}
if@hsp ts.target=12:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000	
if@hsp ts.target=18:tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=(tcy.target)*1000

if@hsp eh2.cnt@hsp<0	:eh2.cnt@hsp=2
if@hsp eh2.cnt@hsp>360:eh2.cnt@hsp=1	


txv.cnt@hsp=cosa(eh2.cnt@hsp)/spd : tyv.cnt@hsp=sina(eh2.cnt@hsp)/spd


hitchklenghx.cnt@hsp=3
hitchklenghy.cnt@hsp=3


tcplusx.cnt@hsp=2
tcplusy.cnt@hsp=2

if@hsp eh=20 : eh=0 : break@hsp							
loop@hsp

return@hsp
*china_cannon

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90								
tf.cnt@hsp=1										
modc=double@hsp((eh2.cnt@hsp+287)*3.1415926535897932384626433832795)/180
tk.cnt@hsp=modc
ts.cnt@hsp=52										
if@hsp mode=1:ts.cnt@hsp=52

tx.cnt@hsp=(tcx.target+3)*1000 :ty.cnt@hsp=(tcy.target+14)*1000		

txv.cnt@hsp=0
tyv.cnt@hsp=0	


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

if@hsp eh=1 : eh=0  :break@hsp							
loop@hsp

return@hsp


*object_move


sonzai=0
foreach@hsp tf
if@hsp tf.cnt@hsp=-1:break@hsp
if@hsp tf.cnt@hsp<1 :continue@hsp						
sonzai+=1


tx.cnt@hsp+=txv.cnt@hsp : ty.cnt@hsp+=tyv.cnt@hsp			
tx2.cnt@hsp=tx.cnt@hsp/1000 : ty2.cnt@hsp=ty.cnt@hsp/1000	


tcx.cnt@hsp=tx2.cnt@hsp+tcplusx.cnt@hsp
tcy.cnt@hsp=ty2.cnt@hsp+tcplusy.cnt@hsp

if@hsp (tx2.cnt@hsp>355)|(tx2.cnt@hsp<-64)|(ty2.cnt@hsp<-64)|(ty2.cnt@hsp>440)&ts.cnt@hsp!42{

if@hsp ts.cnt@hsp=14:fantao+=1
if@hsp (ts.cnt@hsp=44) : gook += 1 : dis.cnt@hsp = 1

tf.cnt@hsp=0
ts.cnt@hsp=0
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
continue@hsp

}

pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4



if@hsp ts.cnt@hsp=1{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,0,32,32
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=100{
if@hsp objtimek.cnt@hsp<=100+0*1&objtimek.cnt@hsp>=100{
target=cnt@hsp
gosub@hsp *put_enemyshot1
target=0
objtimek.cnt@hsp=0
}
}
}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
}				
}				
}


if@hsp ts.cnt@hsp=5{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,31,31,31
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+1*30&objtimek.cnt@hsp>=50{
target=cnt@hsp
if@hsp objtimek.cnt@hsp\30=1:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp=50{
resetmove cnt@hsp,270,5
}

}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,31,31,31
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}

}

}


if@hsp ts.cnt@hsp=23{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,94,32,32
if@hsp objtimek.cnt@hsp<=500&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+50*7&objtimek.cnt@hsp>=50{
target=cnt@hsp:spd=6:type=4			
if@hsp objtimek.cnt@hsp\7=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp=50{
txv.cnt@hsp=0:tyv.cnt@hsp=0

}
if@hsp objtimek.cnt@hsp=500{
resetmove cnt@hsp,270,5
}

}else@hsp{
if@hsp zhp.cnt@hsp>0:break@hsp
nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,31,31,31
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}

}

}






if@hsp ts.cnt@hsp=9{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,35,30
gcopy@hsp 4,0,62,35,30
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=20{
eh2.cnt@hsp+=20:if@hsp eh2.cnt@hsp>=270:eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
if@hsp objtimek.cnt@hsp<=20+0*1&objtimek.cnt@hsp>=20{
target=cnt@hsp:speed=3
gosub@hsp *danmak3
target=0:speed=0
objtimek.cnt@hsp=0
}
}
}else@hsp{
if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1


hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}				
}				
}






if@hsp ts.cnt@hsp=22{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,35,30
gcopy@hsp 4,0,62,35,30
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=20{
eh2.cnt@hsp-=20:if@hsp eh2.cnt@hsp<0:eh2.cnt@hsp=340
if@hsp eh2.cnt@hsp<=270:eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
if@hsp objtimek.cnt@hsp<=20+0*1&objtimek.cnt@hsp>=20{
target=cnt@hsp:speed=3
gosub@hsp *danmak3
target=0:speed=0
objtimek.cnt@hsp=0
}
}
}else@hsp{
if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1


hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}				
}				
}


if@hsp ts.cnt@hsp=16{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,94,32,32


}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,94,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
}				
}				
}


if@hsp ts.cnt@hsp=17{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,94,32,32

if@hsp objtimek.cnt@hsp<=70&objtimek.cnt@hsp>=25{
eh2.cnt@hsp+=9:if@hsp eh2.cnt@hsp>=359:eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/1: tyv.cnt@hsp=sina(eh2.cnt@hsp)/1
}
if@hsp objtimek.cnt@hsp>=300{
objtimek.cnt@hsp=0
}
}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp

gosub@hsp *endanmak
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,94,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
}				
}				

}


if@hsp ts.cnt@hsp=31{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,0,32,32

if@hsp objtimek.cnt@hsp<=50&objtimek.cnt@hsp>=0{
eh2.cnt@hsp+=2: if@hsp eh2.cnt@hsp>=180: eh2.cnt@hsp=180
resetmove cnt@hsp,eh2.cnt@hsp,2
}
if@hsp objtimek.cnt@hsp>=40{
eh2.cnt@hsp-=2: if@hsp eh2.cnt@hsp<=90: eh2.cnt@hsp=90
resetmove cnt@hsp,eh2.cnt@hsp,2
}

if@hsp objtimek.cnt@hsp<=100&objtimek.cnt@hsp>=0{
if@hsp objtimek.cnt@hsp<=0+5*10&objtimek.cnt@hsp>=0{
target=cnt@hsp
if@hsp frame\10=0:gosub@hsp *danmak3
target=0
objtimek.cnt@hsp=0
}
}
}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
}				
}				
}

if@hsp ts.cnt@hsp=32{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,31,31,31
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+10*3&objtimek.cnt@hsp>=50{
target=cnt@hsp:spd=5:type=2
if@hsp objtimek.cnt@hsp\3=1:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp=50{
resetmove cnt@hsp,270,5
}

}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,31,31,31
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}

}

}
if@hsp ts.cnt@hsp=33{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,31,31,31
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+10*3&objtimek.cnt@hsp>=50{
target=cnt@hsp:spd=5:type=2
if@hsp objtimek.cnt@hsp\3=1:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp=50{
resetmove cnt@hsp,270,5
}

}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,31,31,31
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}

}

}

if@hsp ts.cnt@hsp=34{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,31,31,31
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+10*5&objtimek.cnt@hsp>=50{
target=cnt@hsp:spd=5:type=0
if@hsp objtimek.cnt@hsp\5=1:gosub@hsp *neraiendanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp=50{
resetmove cnt@hsp,270,5
}

}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,31,31,31
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}

}

}


if@hsp ts.cnt@hsp=36{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,0,32,32
if@hsp objtimek.cnt@hsp>=50{
txv.cnt@hsp=0 : tyv.cnt@hsp=0
}
if@hsp objtimek.cnt@hsp<=300&objtimek.cnt@hsp>=100{
if@hsp objtimek.cnt@hsp<=100+1&objtimek.cnt@hsp>=100{
target=cnt@hsp:mukaukakudo=90
gosub@hsp *laser_ramon1
target=0:mukaukakudo=0

}
}
if@hsp objtimek.cnt@hsp>=300{
resetmove cnt@hsp,270,3
}
}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
}				
}				
}


if@hsp ts.cnt@hsp=38{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,32,32
gcopy@hsp 4,0,31,31,31
if@hsp objtimek.cnt@hsp<=330&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+40*7&objtimek.cnt@hsp>=50{
target=cnt@hsp:type=2:spd=5
if@hsp objtimek.cnt@hsp\7=1:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
}
if@hsp objtimek.cnt@hsp=50{
txv.cnt@hsp=0:tyv.cnt@hsp=0
}
if@hsp objtimek.cnt@hsp>=330{
resetmove cnt@hsp,270,3
}

}else@hsp{

nohit cnt@hsp

if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item
target=0
dis.cnt@hsp=2
}
objtimek.cnt@hsp+=1

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,31,31,31
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

}

}

}


if@hsp ts.cnt@hsp=40{

if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,64,64
gcopy@hsp 7,0,0,64,64

if@hsp objtimek.cnt@hsp=40:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp=800:objtimek.cnt@hsp=40

if@hsp (objtimek.cnt@hsp>=100) & (objtimek.cnt@hsp<=180){
if@hsp objtimek.cnt@hsp\20=0{
getsankaktcy cnt@hsp
target=cnt@hsp:mukaukakudo=b:spd=2
gosub@hsp *laser_ramon2
target=0:mukaukakudo=0:spd=0
}
}

}else@hsp{
if@hsp zhp.cnt@hsp>0:break@hsp
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9

}
}
}


if@hsp ts.cnt@hsp=6{

if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,64,64
gcopy@hsp 7,0,0,64,64

if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=50{
if@hsp objtimek.cnt@hsp<=50+2*30&objtimek.cnt@hsp>=50{
eh2.cnt@hsp=180
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
target=cnt@hsp
if@hsp objtimek.cnt@hsp\30=1:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp<=650&objtimek.cnt@hsp>=150{
if@hsp objtimek.cnt@hsp<=150+20*25&objtimek.cnt@hsp>=150{
eh2.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0
target=cnt@hsp
if@hsp objtimek.cnt@hsp\25=1:gosub@hsp *danmak2
target=0
}
}
if@hsp objtimek.cnt@hsp<=700&objtimek.cnt@hsp>=650{
if@hsp objtimek.cnt@hsp<=650+20*25&objtimek.cnt@hsp>=650{
eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
target=cnt@hsp
if@hsp objtimek.cnt@hsp\25=1:gosub@hsp *danmak2
target=0
target=cnt@hsp
if@hsp objtimek.cnt@hsp\30=1:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp>=700:objtimek.cnt@hsp=0	
}else@hsp{
if@hsp chp>0:break@hsp
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9
gook=1
}
}
}


if@hsp ts.cnt@hsp=18{

if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,64,64
gcopy@hsp 5,37,29,26,33

if@hsp objtimek.cnt@hsp<=100&objtimek.cnt@hsp>=50{
eh2.cnt@hsp=180:
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3
}
if@hsp objtimek.cnt@hsp<=200&objtimek.cnt@hsp>=100{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=100+1*10&objtimek.cnt@hsp>=100{
target=cnt@hsp:spd=1:type=1			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak2
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=150&objtimek.cnt@hsp>=110{
eh2.cnt@hsp=20
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=250&objtimek.cnt@hsp>=150{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=250+1*10&objtimek.cnt@hsp>=150{
target=cnt@hsp:spd=1:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak2
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=290&objtimek.cnt@hsp>=250{
eh2.cnt@hsp=230
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=300&objtimek.cnt@hsp>=290{
txv.cnt@hsp=0:tyv.cnt@hsp=0

}
if@hsp objtimek.cnt@hsp<=330&objtimek.cnt@hsp>=300{
eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
if@hsp objtimek.cnt@hsp<=300+15*2&objtimek.cnt@hsp>=300{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *houtyou
target=0
}
}
if@hsp objtimek.cnt@hsp<=380&objtimek.cnt@hsp>=330{
eh2.cnt@hsp=180
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
if@hsp objtimek.cnt@hsp<=330+15*10&objtimek.cnt@hsp>=330{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *houtyou
target=0
}
}
if@hsp objtimek.cnt@hsp<=400&objtimek.cnt@hsp>=380{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=380+1*10&objtimek.cnt@hsp>=380{
target=cnt@hsp:spd=1:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak2
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=425&objtimek.cnt@hsp>=400{
eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=525&objtimek.cnt@hsp>=425{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=425+10*10&objtimek.cnt@hsp>=425{
target=cnt@hsp:spd=3:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=3			
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=725&objtimek.cnt@hsp>=525{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=525+10*10&objtimek.cnt@hsp>=525{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=2			
if@hsp objtimek.cnt@hsp\7=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *endanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<810&objtimek.cnt@hsp>=800{
eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=820&objtimek.cnt@hsp>=810{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=810+3*2&objtimek.cnt@hsp>=810{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *laser
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=880&objtimek.cnt@hsp>=870{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=870+3*2&objtimek.cnt@hsp>=870{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *laser
target=0:spd=0:type=0

}
}

if@hsp objtimek.cnt@hsp<=920&objtimek.cnt@hsp>=910{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=920+1*2&objtimek.cnt@hsp>=910{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *laser
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=940&objtimek.cnt@hsp>=930{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=940+1*2&objtimek.cnt@hsp>=930{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *laser
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=960&objtimek.cnt@hsp>=950{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=960+1*2&objtimek.cnt@hsp>=950{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *laser
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=970&objtimek.cnt@hsp>=960{
txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp<=970+1*2&objtimek.cnt@hsp>=960{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *laser
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=975&objtimek.cnt@hsp>=970{
eh2.cnt@hsp=25
txv.cnt@hsp=cosa(eh2.cnt@hsp)/7 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5
}
if@hsp objtimek.cnt@hsp>975:objtimek.cnt@hsp=0


}else@hsp{
if@hsp chp>0:break@hsp
if@hsp objtimek.cnt@hsp=1{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10
}
if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item2
target=0
gook=1
dis.cnt@hsp=2
}
gmode@hsp 2,64,64
gcopy@hsp 5,37,29,26,33
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000
disbullet(10)



if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=2:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0

gosub@hsp *disall

}


}
}


if@hsp ts.cnt@hsp=39{

if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,64,64
gcopy@hsp 5,37,29,26,33

if@hsp objtimek.cnt@hsp<=21&objtimek.cnt@hsp>=20{
resetmove cnt@hsp,180,2
}
if@hsp objtimek.cnt@hsp<=41&objtimek.cnt@hsp>=40{
resetmove cnt@hsp,0,2
}
if@hsp objtimek.cnt@hsp<=101&objtimek.cnt@hsp>=100{
resetmove cnt@hsp,180,2
}
if@hsp objtimek.cnt@hsp<=171&objtimek.cnt@hsp>=170{
resetmove cnt@hsp,0,2
}
if@hsp objtimek.cnt@hsp<=201&objtimek.cnt@hsp>=200{
txv.cnt@hsp=0:tyv.cnt@hsp=0
}
if@hsp objtimek.cnt@hsp<=401&objtimek.cnt@hsp>=400{
resetmove cnt@hsp,0,2
}
if@hsp objtimek.cnt@hsp<=421&objtimek.cnt@hsp>=420{
txv.cnt@hsp=0:tyv.cnt@hsp=0
}
if@hsp objtimek.cnt@hsp<=701&objtimek.cnt@hsp>=700{
resetmove cnt@hsp,180,2
}
if@hsp objtimek.cnt@hsp<=721&objtimek.cnt@hsp>=720{
txv.cnt@hsp=0:tyv.cnt@hsp=0
}
if@hsp objtimek.cnt@hsp>=20&objtimek.cnt@hsp<=200{
if@hsp objtimek.cnt@hsp<=20+100*5&objtimek.cnt@hsp>=20{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *houtyou
target=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *endanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp>=200&objtimek.cnt@hsp<=400{
if@hsp objtimek.cnt@hsp<=200+20*5&objtimek.cnt@hsp>=200{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *houtyou2
target=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *endanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp>=420&objtimek.cnt@hsp<=620{
if@hsp objtimek.cnt@hsp<=420+20*5&objtimek.cnt@hsp>=420{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *houtyou2
target=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *endanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp>=620&objtimek.cnt@hsp<=820{
if@hsp objtimek.cnt@hsp<=620+2*10&objtimek.cnt@hsp>=620{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *houtyou3
target=0
}
}
if@hsp objtimek.cnt@hsp>=720&objtimek.cnt@hsp<=820{
if@hsp objtimek.cnt@hsp<=720+40*10&objtimek.cnt@hsp>=720{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *houtyou3
target=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=2			
if@hsp objtimek.cnt@hsp\7=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *endanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp>=820&objtimek.cnt@hsp<=920{
if@hsp objtimek.cnt@hsp<=820+40*10&objtimek.cnt@hsp>=820{
target=cnt@hsp	
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *houtyou3
target=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=2			
if@hsp objtimek.cnt@hsp\7=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *endanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp>=1000:objtimek.cnt@hsp=0

}else@hsp{
if@hsp chp>0:break@hsp
if@hsp objtimek.cnt@hsp=1{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10
}
if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item2
target=0
gook=1
dis.cnt@hsp=2
}
gmode@hsp 2,64,64
gcopy@hsp 5,37,29,26,33
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000
disbullet(10)



if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=2:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0

gosub@hsp *disall

}


}
}



if@hsp ts.cnt@hsp=12{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2
gcopy@hsp 9,0,0,128,64

if@hsp objtimek.cnt@hsp=249{
if@hsp stage!3:dmplay 100,3
}
if@hsp objtimek.cnt@hsp<=850&objtimek.cnt@hsp>=100{
tx.cnt@hsp-=txv.cnt@hsp:ty.cnt@hsp-=tyv.cnt@hsp
}
if@hsp objtimek.cnt@hsp<=860&objtimek.cnt@hsp>=850{
eh2.cnt@hsp=180
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=1010&objtimek.cnt@hsp>=1000{
eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=1000&objtimek.cnt@hsp>=860{
tx.cnt@hsp-=txv.cnt@hsp:ty.cnt@hsp-=tyv.cnt@hsp
}
if@hsp objtimek.cnt@hsp<=300&objtimek.cnt@hsp>=250{
if@hsp objtimek.cnt@hsp<=250+4*6&objtimek.cnt@hsp>=250{
target=cnt@hsp
if@hsp objtimek.cnt@hsp\6=0:gosub@hsp *endanmak
target=0
}
}
if@hsp objtimek.cnt@hsp<=400&objtimek.cnt@hsp>=300{
if@hsp objtimek.cnt@hsp<=400+5*20&objtimek.cnt@hsp>=300{
target=cnt@hsp
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *danmak2
target=0
}
}
if@hsp objtimek.cnt@hsp<=500&objtimek.cnt@hsp>=400{
if@hsp objtimek.cnt@hsp<=500+7*10&objtimek.cnt@hsp>=400{
target=cnt@hsp
ds_play 10
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *danmak4
target=0
}
}
if@hsp objtimek.cnt@hsp<=750&objtimek.cnt@hsp>=550{
if@hsp objtimek.cnt@hsp<=750+20*10&objtimek.cnt@hsp>=550{
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=850&objtimek.cnt@hsp>=750{
if@hsp objtimek.cnt@hsp<=850+10*10&objtimek.cnt@hsp>=750{
target=cnt@hsp:spd=3:type=1			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp>=1010:objtimek.cnt@hsp=250
}else@hsp{
if@hsp zhp.cnt@hsp>=1:break@hsp
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9
gook=1
}
}
}


if@hsp ts.cnt@hsp=25{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2
if@hsp objtimek.cnt@hsp<340:gcopy@hsp 11,0,0,68,83
if@hsp objtimek.cnt@hsp=1:mmstop@hsp:dmplay 0,8
if@hsp objtimek.cnt@hsp=200:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp=340:
if@hsp objtimek.cnt@hsp>=340:gcopy@hsp 11,0,84,68,78

if@hsp objtimek.cnt@hsp<=600&objtimek.cnt@hsp>=340{
if@hsp objtimek.cnt@hsp<=340+30*10&objtimek.cnt@hsp>=340{
target=cnt@hsp:spd=3:type=2			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=6:type=3			
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=910&objtimek.cnt@hsp>=610{
if@hsp objtimek.cnt@hsp<=610+50*10&objtimek.cnt@hsp>=610{
target=cnt@hsp:spd=3:type=1		
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=6:type=0			
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=5:type=0			
if@hsp objtimek.cnt@hsp\50=0:gosub@hsp *neraiendanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=1210&objtimek.cnt@hsp>=910{
if@hsp objtimek.cnt@hsp<=910+50*10&objtimek.cnt@hsp>910{
target=cnt@hsp:spd=3:type=1		
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=cnt@hsp:spd=3:type=1		
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0
}
}
if@hsp objtimek.cnt@hsp<=1510&objtimek.cnt@hsp>=1210{
if@hsp objtimek.cnt@hsp<=1210+50*10&objtimek.cnt@hsp>1210{
target=cnt@hsp:spd=6:type=3			
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=6:type=3			
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=1810&objtimek.cnt@hsp>=1510{
if@hsp objtimek.cnt@hsp<=1510+50*10&objtimek.cnt@hsp>1510{
target=cnt@hsp:spd=6:type=5			
if@hsp objtimek.cnt@hsp\15=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=6:type=5			
if@hsp objtimek.cnt@hsp\15=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=2110&objtimek.cnt@hsp>=1810{
if@hsp objtimek.cnt@hsp<=1810+50*10&objtimek.cnt@hsp>1810{
target=cnt@hsp:spd=6:type=5			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:spd=0:type=0
target=cnt@hsp:spd=6:type=5			
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=2200&objtimek.cnt@hsp>=2110{
resetmove cnt@hsp,300,5
}
if@hsp objtimek.cnt@hsp<=2510&objtimek.cnt@hsp>=2150{
if@hsp objtimek.cnt@hsp<=2150+20*100&objtimek.cnt@hsp>2150{
txv.cnt@hsp=0:tyv.cnt@hsp=0
target=cnt@hsp:spd=5:type=6			
if@hsp objtimek.cnt@hsp\50=0:gosub@hsp *endanmak
target=0:spd=0:type=0

target=cnt@hsp:spd=2:type=2			
if@hsp objtimek.cnt@hsp\20=0:gosub@hsp *put_enemyshot1
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=2600&objtimek.cnt@hsp>=2510{
resetmove cnt@hsp,180,5
}
if@hsp objtimek.cnt@hsp<=2710&objtimek.cnt@hsp>=2550{
if@hsp objtimek.cnt@hsp<=2550+30*100&objtimek.cnt@hsp>2550{
txv.cnt@hsp=0:tyv.cnt@hsp=0
target=cnt@hsp:spd=5:type=6			
if@hsp objtimek.cnt@hsp\50=0:gosub@hsp *endanmak
target=0:spd=0:type=0

}
}
if@hsp objtimek.cnt@hsp<=2800&objtimek.cnt@hsp>=2710{
resetmove cnt@hsp,60,8
}
if@hsp objtimek.cnt@hsp>=2800:objtimek.cnt@hsp=340:txv.cnt@hsp=0:tyv.cnt@hsp=0

}else@hsp{
if@hsp zhp.cnt@hsp>=1:break@hsp
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9
mmstop@hsp
dmstop
mmplay@hsp 13
gook=1
disbullet(10)
}
}
}


if@hsp ts.cnt@hsp=14{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1


kyorx=tx2.cnt@hsp-mx
kyory=ty2.cnt@hsp-my

a=atan@hsp(kyory,kyorx)

gmode@hsp 2,12,9
grotate@hsp 9,0,20,a,24,18
gook=0
if@hsp objtimek.cnt@hsp>=40{
target=cnt@hsp
if@hsp objtimek.cnt@hsp\30=0:gosub@hsp *danmak4
target=0

}

if@hsp objtimek.cnt@hsp<=200&objtimek.cnt@hsp>=10+(abs@hsp(a)*20){
eh2.cnt@hsp+=5:if@hsp eh2.cnt@hsp>=360:eh2.cnt@hsp=0
txv.cnt@hsp=cosa(eh2.cnt@hsp)/4 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/4
}

if@hsp objtimek.cnt@hsp>=200{
objtimek.cnt@hsp=0
}
}else@hsp{

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000
objtimek.cnt@hsp+=1

if@hsp dis.cnt@hsp=1{
fantao+=1
dis.cnt@hsp=2
}

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*32
gmode@hsp 2,32,32
gcopy@hsp 4,objtimek3.cnt@hsp,0,32,32
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0 : tyv.cnt@hsp=0

}
}
}

if@hsp ts.cnt@hsp=50{


color@hsp 0,0,0
gmode@hsp 2,48,80
gcopy@hsp 15,0,0,48,80
gmode@hsp 2,,

if@hsp cannon!5&cannon!6{
objtimek.cnt@hsp+=1
if@hsp (objtimek.cnt@hsp = 50) : txv.cnt@hsp = 0 : tyv.cnt@hsp = 0
if@hsp (objtimek.cnt@hsp = 100) : turn += 1
if@hsp cannon = 1 : target = cnt@hsp : mukaukakudo = 90 : gosub@hsp *c_cannon : cannon = 2 
}
if@hsp cannon >= 5 {
if@hsp dis.cnt@hsp=0{
if@hsp cannon=5:objtimek.cnt@hsp = 0: cannon=6
objtimek.cnt@hsp += 1
if@hsp objtimek.cnt@hsp <= 20 {
resetmove cnt@hsp,200,3
}
if@hsp objtimek.cnt@hsp >= 80 & objtimek.cnt@hsp <= 160 {
resetmove cnt@hsp,0,5
}
if@hsp wapon2kaun>=560 & wapon2kaun<=599{

if@hsp wapon2kaun=561:ds_play 8
color@hsp 255,255,255
pos@hsp 50,220
gmode@hsp 2,48,80
gcopy@hsp 15,0,0,48,20
pos@hsp 50+50,220
font@hsp "MS　ゴシック",30
mes@hsp "モレールジャマー"



}

if@hsp objtimek.cnt@hsp = 720	:resetmove cnt@hsp,90,1
if@hsp objtimek.cnt@hsp = 740	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 750	:resetmove cnt@hsp,200,1:target=cnt@hsp:gosub@hsp *laser:target=0
if@hsp objtimek.cnt@hsp = 760	:resetmove cnt@hsp,340,1:target=cnt@hsp:gosub@hsp *laser:target=0
if@hsp objtimek.cnt@hsp = 780	:resetmove cnt@hsp,200,1:target=cnt@hsp:gosub@hsp *laser:target=0
if@hsp objtimek.cnt@hsp = 800	:resetmove cnt@hsp,340,1:target=cnt@hsp:gosub@hsp *laser:target=0
if@hsp objtimek.cnt@hsp = 810	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 820	:resetmove cnt@hsp,90,1
if@hsp objtimek.cnt@hsp = 840	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 850	:resetmove cnt@hsp,200,1:target=cnt@hsp:gosub@hsp *laser:gosub@hsp *endanmak:target=0
if@hsp objtimek.cnt@hsp = 860	:resetmove cnt@hsp,340,1:target=cnt@hsp:gosub@hsp *laser:
if@hsp objtimek.cnt@hsp = 880	:resetmove cnt@hsp,200,1:target=cnt@hsp:gosub@hsp *laser:gosub@hsp *endanmak:target=0
if@hsp objtimek.cnt@hsp = 900	:resetmove cnt@hsp,340,1:target=cnt@hsp:gosub@hsp *laser:
if@hsp objtimek.cnt@hsp = 910	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 920	:resetmove cnt@hsp,90,1
if@hsp objtimek.cnt@hsp = 940	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 950	:resetmove cnt@hsp,200,1:target=cnt@hsp:gosub@hsp *laser:gosub@hsp *neraiendanmak:target=0
if@hsp objtimek.cnt@hsp = 960	:resetmove cnt@hsp,340,1:target=cnt@hsp:gosub@hsp *laser:
if@hsp objtimek.cnt@hsp = 980	:resetmove cnt@hsp,200,1:target=cnt@hsp:gosub@hsp *laser:gosub@hsp *neraiendanmak:target=0
if@hsp objtimek.cnt@hsp = 1000	:resetmove cnt@hsp,340,1:target=cnt@hsp:gosub@hsp *laser:
if@hsp objtimek.cnt@hsp = 1010	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 2100	:resetmove cnt@hsp,90,2:target=cnt@hsp:gosub@hsp *laser:
if@hsp objtimek.cnt@hsp = 2115	:txv.cnt@hsp=0:tyv.cnt@hsp=0


if@hsp objtimek.cnt@hsp = 21 	:txv.cnt@hsp=0:tyv.cnt@hsp=0:dmplay 0,11
if@hsp objtimek.cnt@hsp = 160 	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 370 	:stage=6:dmplay 0,13
if@hsp objtimek.cnt@hsp = 400	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp = 1100	:dmplay 0,11


if@hsp objtimek.cnt@hsp >= 20 & objtimek.cnt@hsp <= 370{
target=cnt@hsp:type=2:spd=2
if@hsp objtimek.cnt@hsp\25=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *uzudanmak

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0

}
if@hsp objtimek.cnt@hsp >= 2000 & objtimek.cnt@hsp <= 2370{
target=cnt@hsp:type=2:spd=2
if@hsp objtimek.cnt@hsp\25=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *uzudanmak

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0

}

if@hsp objtimek.cnt@hsp = 370:resetmove cnt@hsp,200,3

if@hsp objtimek.cnt@hsp >= 370 & objtimek.cnt@hsp <= 600{
target=cnt@hsp:type=2:spd=2
if@hsp objtimek.cnt@hsp\25=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *uzudanmak

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0
if@hsp objtimek.cnt@hsp<=370+30*100&objtimek.cnt@hsp>370{
target=cnt@hsp:spd=2:type=0
if@hsp objtimek.cnt@hsp\25=0:gosub@hsp *laser
target=0:spd=0:type=0
}

}
if@hsp objtimek.cnt@hsp >= 1100 & objtimek.cnt@hsp <= 1150{
target=cnt@hsp:type=6:spd=1
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1150 & objtimek.cnt@hsp <= 1200{
target=cnt@hsp:type=6:spd=1
if@hsp objtimek.cnt@hsp\10=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1200 & objtimek.cnt@hsp <= 1300{
target=cnt@hsp:type=6:spd=4
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1300 & objtimek.cnt@hsp <= 1350{
target=cnt@hsp:type=6:spd=4
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1450 & objtimek.cnt@hsp <= 1480{
target=cnt@hsp:type=5:spd=2
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1500 & objtimek.cnt@hsp <= 1520{
target=cnt@hsp:type=5:spd=2
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1540 & objtimek.cnt@hsp <= 1570{
target=cnt@hsp:type=5:spd=2
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1590 & objtimek.cnt@hsp <= 1610{
target=cnt@hsp:type=5:spd=2
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1620 & objtimek.cnt@hsp <= 1650{
target=cnt@hsp:type=5:spd=4
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1660 & objtimek.cnt@hsp <= 1700{
target=cnt@hsp:type=5:spd=4
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1780 & objtimek.cnt@hsp <= 1800{
target=cnt@hsp:type=5:spd=2
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 1820 & objtimek.cnt@hsp <= 1850{
target=cnt@hsp:type=5:spd=2
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp > 1900 & objtimek.cnt@hsp <= 2100|kg=1{




if@hsp objtimek.cnt@hsp=1902|kg=1:efx_f=160:efy_f=160:efx_e=160:efy_e=160:ds_play 13:utot=0
if@hsp objtimek.cnt@hsp=1903:efycount=0:efxcount=0
if@hsp frame\3=0:efxcount+=1
if@hsp efxcount=4:efxcount=0:efycount+=1
if@hsp efycount=8:efycount=7:efxcount=1
if@hsp efycount=4{

if@hsp utot=1:break@hsp
target=cnt@hsp:mukaukakudo=90

gosub@hsp *laser_ramon1
tmptate=tcx.cnt@hsp
tcx.cnt@hsp-=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp-=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp+=20
gosub@hsp *laser_ramon1
tcx.cnt@hsp+=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp+=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp=tmptate
target=0:mukaukakudo=0
utot=1:kg=0:ds_play 14
}


pos@hsp (tx.cnt@hsp/1000)-55,(ty.cnt@hsp/1000)-30
gcopy@hsp 16,efx_f*efxcount,efy_f*efycount,efx_e,efy_e
}
if@hsp objtimek.cnt@hsp>=2150:objtimek.cnt@hsp=0:utot=0:efycount=0:efxcount=0
if@hsp hissatuf=2:utot=0:wapon2kaun=550
if@hsp wapon2kaun=599:kg=1:ds_play 10
if@hsp kg=1:kg2=1
if@hsp kg2=1:kg2k+=1
if@hsp kg2k>=300:kg2k=0:kg2=0
}else@hsp{
if@hsp zhp>0:break@hsp
if@hsp objtimek.cnt@hsp=1{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10
}
if@hsp dis.cnt@hsp=1{
target=cnt@hsp
gosub@hsp *put_item2
target=0
gook=1
dis.cnt@hsp=2
}
gmode@hsp 2,64,64
gcopy@hsp 5,37,29,26,33
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000
disbullet(10)



if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=2:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0

gosub@hsp *disall

}
}
}
}
if@hsp ts.cnt@hsp=51{
objtimek.cnt@hsp+=1

color@hsp 0,0,0
gmode@hsp 2,64,64
gcopy@hsp 5,37,29,26,33

if@hsp (objtimek.cnt@hsp = 70) : txv.cnt@hsp = 0 : tyv.cnt@hsp = 0
if@hsp cannon = 3 : target = cnt@hsp : gosub@hsp *bosshit :dis.cnt@hsp = 1 :cannon = 0: ds_play 3

if@hsp dis.cnt@hsp>=1{
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9
gook += 1
}
}

}
if@hsp ts.cnt@hsp=55{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1

gmode@hsp 2,48,80
gcopy@hsp 15,0,0,48,80
gmode@hsp 2,,

if@hsp objtimek.cnt@hsp >= 50&objtimek.cnt@hsp <= 55	:resetmove cnt@hsp,0,2
if@hsp objtimek.cnt@hsp >= 60&objtimek.cnt@hsp >= 70	:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp >= 70&objtimek.cnt@hsp<= 80		:resetmove cnt@hsp,180,1
if@hsp objtimek.cnt@hsp >= 80&objtimek.cnt@hsp<= 130	:txv.cnt@hsp=0:tyv.cnt@hsp=0

if@hsp objtimek.cnt@hsp>=200&objtimek.cnt@hsp<=220:resetmove cnt@hsp,180,1
if@hsp objtimek.cnt@hsp>=221&objtimek.cnt@hsp<=250:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp>=340&objtimek.cnt@hsp<=360:resetmove cnt@hsp,0,1
if@hsp objtimek.cnt@hsp>=361&objtimek.cnt@hsp<=380:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp>=450&objtimek.cnt@hsp<=500:resetmove cnt@hsp,180,2
if@hsp objtimek.cnt@hsp>=501&objtimek.cnt@hsp<=580:txv.cnt@hsp=0:tyv.cnt@hsp=0
if@hsp objtimek.cnt@hsp>=590&objtimek.cnt@hsp<=620:resetmove cnt@hsp,0,2
if@hsp objtimek.cnt@hsp>=621&objtimek.cnt@hsp<=680:txv.cnt@hsp=0:tyv.cnt@hsp=0

if@hsp objtimek.cnt@hsp >= 20 & objtimek.cnt@hsp <= 670{
target=cnt@hsp:type=2:spd=2
if@hsp objtimek.cnt@hsp\25=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *uzudanmak

target=cnt@hsp:spd=3:type=1		
if@hsp frame\10=0:gosub@hsp *gyakuuzudanmak
target=0:spd=0:type=0

}

if@hsp objtimek.cnt@hsp >= 10 & objtimek.cnt@hsp <= 20{
txv.cnt@hsp=0:tyv.cnt@hsp=0
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 50 & objtimek.cnt@hsp <= 60{
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 100 & objtimek.cnt@hsp <= 110{
txv.cnt@hsp=0:tyv.cnt@hsp=0
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 150 & objtimek.cnt@hsp <= 160{
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 200 & objtimek.cnt@hsp <= 210{
txv.cnt@hsp=0:tyv.cnt@hsp=0
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 250 & objtimek.cnt@hsp <= 260{
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >= 300 & objtimek.cnt@hsp <= 310{
txv.cnt@hsp=0:tyv.cnt@hsp=0
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp >=350 & objtimek.cnt@hsp <= 360{
target=cnt@hsp:type=5:spd=5
if@hsp objtimek.cnt@hsp\2=0:gosub@hsp *gyakuuzudanmak
target=0:type=0:spd=0
}
if@hsp objtimek.cnt@hsp>=300&objtimek.cnt@hsp<=310:kg=1
if@hsp objtimek.cnt@hsp=400:kg=1
if@hsp objtimek.cnt@hsp=520:kg=1
if@hsp kg=1{

if@hsp objtimek.cnt@hsp=302|kg=1:efx_f=160:efy_f=160:efx_e=160:efy_e=160:ds_play 13:utot=0
if@hsp objtimek.cnt@hsp=303:efycount=0:efxcount=0
if@hsp objtimek.cnt@hsp=403:efycount=0:efxcount=0
if@hsp frame\3=0:efxcount+=1
if@hsp efxcount=4:efxcount=0:efycount+=1
if@hsp efycount=8:efycount=7:efxcount=1
if@hsp efycount=4{

if@hsp utot=1:break@hsp
target=cnt@hsp:mukaukakudo=90

gosub@hsp *laser_ramon1
tmptate=tcx.cnt@hsp
tcx.cnt@hsp-=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp-=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp+=20
gosub@hsp *laser_ramon1
tcx.cnt@hsp+=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp+=10
gosub@hsp *laser_ramon1
tcx.cnt@hsp=tmptate
target=0:mukaukakudo=0
utot=1:kg=0:ds_play 14
}


pos@hsp (tx.cnt@hsp/1000)-55,(ty.cnt@hsp/1000)-30
gcopy@hsp 16,efx_f*efxcount,efy_f*efycount,efx_e,efy_e
}

if@hsp objtimek.cnt@hsp >= 700 & objtimek.cnt@hsp <= 705{

target=cnt@hsp:type=9:spd=2
if@hsp objtimek.cnt@hsp\5=0:gosub@hsp *uzudanmak
target=0:type=0:spd=0
}

if@hsp objtimek.cnt@hsp>=1000:objtimek.cnt@hsp=0
if@hsp hissatuf=2:utot=0:wapon2kaun=550
if@hsp wapon2kaun=599:kg=1:ds_play 10
if@hsp kg=1:kg2=1
if@hsp kg2=1:kg2k+=1
if@hsp kg2k>=300:kg2k=0:kg2=0

}else@hsp{
if@hsp zhp>0:break@hsp
if@hsp objtimek.cnt@hsp=1{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/10 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/10
}

gmode@hsp 2,64,64
gcopy@hsp 5,37,29,26,33
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000
disbullet(10)



if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=2:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0

gosub@hsp *disall
gook+=1
dmplay 0,16
}


}
}







if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13|ts.cnt@hsp=19|ts.cnt@hsp=24|ts.cnt@hsp=27|ts.cnt@hsp=37|ts.cnt@hsp=42{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2
if@hsp ts.cnt@hsp=2:gcopy@hsp 5,2,0,14,14
if@hsp ts.cnt@hsp=24:gcopy@hsp 5,13,123,14,12
if@hsp ts.cnt@hsp=7:gcopy@hsp 5,2,14,13,13
if@hsp ts.cnt@hsp=10:gcopy@hsp 5,2,62,13,14
if@hsp ts.cnt@hsp=19{
gmode@hsp 2,13,55
grotate@hsp 5,2,74,tk.cnt@hsp,13,45
}
if@hsp ts.cnt@hsp=27:gcopy@hsp 5,65,0,25,27
if@hsp ts.cnt@hsp=37{

gmode@hsp 5,14,5,200
grotate@hsp 5,66,30,tk.cnt@hsp,14+objtimek2.cnt@hsp,5+(objtimek.cnt@hsp*8)
gmode@hsp 2,,

if@hsp objtimek.cnt@hsp>=50:objtimek.cnt@hsp=50:objtimek2.cnt@hsp+=1
if@hsp objtimek.cnt@hsp<50 :ty.cnt@hsp+=double@hsp(objtimek.cnt@hsp/5)*1000
if@hsp objtimek2.cnt@hsp>14:objtimek2.cnt@hsp=15:objtimek3.cnt@hsp+=1

if@hsp objtimek3.cnt@hsp>=100{
ty.cnt@hsp+=5*1000:objtimek.cnt@hsp-=2
if@hsp cannon=2:cannon=3
}

hitchklenghx.cnt@hsp=objtimek2.cnt@hsp-8
hitchklenghy.cnt@hsp=5+(objtimek.cnt@hsp*4)


tcplusx.cnt@hsp=-5
tcplusy.cnt@hsp=0

}
if@hsp ts.cnt@hsp=42{

gmode@hsp 5,14,5,200
grotate@hsp 5,66,30,tk.cnt@hsp,4+objtimek2.cnt@hsp,5+(objtimek.cnt@hsp*9)
if@hsp objtimek.cnt@hsp>=50{
objtimek.cnt@hsp=50
txv.cnt@hsp=0:tyv.cnt@hsp=0
objtimek3.cnt@hsp+=1

if@hsp objtimek3.cnt@hsp\5=0&(objtimek3.cnt@hsp<=199)&zhp(hm.cnt@hsp)>0{
if@hsp objtimek2.cnt@hsp<14:objtimek2.cnt@hsp+=10
mukaukakudo=eh2.cnt@hsp
spd=1
target=hm.cnt@hsp
gosub@hsp *laser_ramon3
mukaukakudo=0
spd=0
target=0
}
}

if@hsp (objtimek3.cnt@hsp>=100)|(dis(hm.cnt@hsp)=1) :resetmove cnt@hsp,eh2.cnt@hsp,1:objtimek.cnt@hsp-=2:objtimek3.cnt@hsp=-2
if@hsp objtimek3.cnt@hsp<0:objtimek3.cnt@hsp=-2:resetmove cnt@hsp,eh2.cnt@hsp,1:objtimek.cnt@hsp-=2

}
if@hsp ts.cnt@hsp=13{
gcopy@hsp 5,2,61,13,13
if@hsp objtimek.cnt@hsp<=60&objtimek.cnt@hsp>=50{
target=cnt@hsp
getsankak target
eh2.cnt@hsp=b
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
target=0
}


}
}else@hsp{
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

txv.cnt@hsp=0:tyv.cnt@hsp=0

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*13
if@hsp objtimek2.cnt@hsp>2{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0

}
gmode@hsp 2
color@hsp 255,255,255
if@hsp ts.cnt@hsp=2:gcopy@hsp 5,15+objtimek3.cnt@hsp,0,13,13
if@hsp ts.cnt@hsp=42:gcopy@hsp 5,15+objtimek3.cnt@hsp,0,13,13
if@hsp ts.cnt@hsp=24:gcopy@hsp 5,13+objtimek3.cnt@hsp,123,13,13
if@hsp ts.cnt@hsp=7:gcopy@hsp 5,15+objtimek3.cnt@hsp,14,13,13
if@hsp ts.cnt@hsp=10:gcopy@hsp 5,15+objtimek3.cnt@hsp,14,13,13
if@hsp ts.cnt@hsp=13:gcopy@hsp 5,15+objtimek3.cnt@hsp,62,13,13
if@hsp ts.cnt@hsp=19:gcopy@hsp 5,15+objtimek3.cnt@hsp,62,13,13
if@hsp ts.cnt@hsp=27:gcopy@hsp 5,65+objtimek3.cnt@hsp*2,0,25,26
}
}


if@hsp ts.cnt@hsp=20{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2
gcopy@hsp 5,4,2,12,12
target=cnt@hsp
getsankak target

target=0

if@hsp objtimek.cnt@hsp<=25&objtimek.cnt@hsp>=0{

if@hsp eh2.cnt@hsp>270&eh2.cnt@hsp<359	:eh2.cnt@hsp+=5
if@hsp eh2.cnt@hsp<270&eh2.cnt@hsp>90	:eh2.cnt@hsp-=5
if@hsp eh2.cnt@hsp>0-1&eh2.cnt@hsp<90	:eh2.cnt@hsp+=5

if@hsp eh2.cnt@hsp>359 : eh2.cnt@hsp=0
if@hsp eh2.cnt@hsp<0   : eh2.cnt@hsp=359
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
if@hsp objtimek.cnt@hsp<=30&objtimek.cnt@hsp>=30{

if@hsp stage=4|stage=6{

eh2.cnt@hsp=b
if@hsp mx<=50|my<=ty2.cnt@hsp|mx>=300:eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/1 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/1
}
if@hsp stage=2{
eh2.cnt@hsp=b
txv.cnt@hsp=cosa(eh2.cnt@hsp)/1 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/1
}
}


}else@hsp{
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

txv.cnt@hsp=0:tyv.cnt@hsp=0

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*13
if@hsp objtimek2.cnt@hsp>2{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0

}
gmode@hsp 2
gcopy@hsp 5,15+objtimek3.cnt@hsp,0,13,13



}
}

if@hsp ts.cnt@hsp=26|ts.cnt@hsp=56{
if@hsp dis.cnt@hsp=0{
if@hsp ts.cnt@hsp=26{
objtimek.cnt@hsp+=1
gmode@hsp 2
gcopy@hsp 5,2,0,14,14
target=cnt@hsp
getsankak target
target=0

if@hsp objtimek.cnt@hsp<=50&objtimek.cnt@hsp>=10{

txv.cnt@hsp=cosa(eh2.cnt@hsp)/(objtimek.cnt@hsp/4)
tyv.cnt@hsp=sina(eh2.cnt@hsp)/(objtimek.cnt@hsp/4)
}
if@hsp objtimek.cnt@hsp<=50&objtimek.cnt@hsp>=50{

eh2.cnt@hsp=b
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}
}
if@hsp ts.cnt@hsp=56{
objtimek.cnt@hsp+=1
gmode@hsp 2
gcopy@hsp 5,2,0,14,14
target=cnt@hsp
getsankak target
target=0

if@hsp objtimek.cnt@hsp<=50&objtimek.cnt@hsp>=10{

txv.cnt@hsp=cosa(eh2.cnt@hsp)/(objtimek.cnt@hsp/4)
tyv.cnt@hsp=sina(eh2.cnt@hsp)/(objtimek.cnt@hsp/4)
}
if@hsp objtimek.cnt@hsp<=50&objtimek.cnt@hsp>=50{

target=cnt@hsp
gosub@hsp *endanmak
target=0
dis.cnt@hsp=1
}
}

}else@hsp{
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

txv.cnt@hsp=0:tyv.cnt@hsp=0

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=objtimek2.cnt@hsp*13
if@hsp objtimek2.cnt@hsp>2{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0:dis.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0

}
gmode@hsp 2
gcopy@hsp 5,15+objtimek3.cnt@hsp,0,13,13



}
}





if@hsp ts.cnt@hsp=3{
objtimek.cnt@hsp+=1

gmode@hsp 5,,,255
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,10

if@hsp objtimek.cnt@hsp=50{
mx=150:my=350
mutekif=2
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
if@hsp life<=0:goto@hsp *q_continue
}
}
if@hsp ts.cnt@hsp=35{
objtimek.cnt@hsp+=1

gmode@hsp 5,,,255
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,10

if@hsp objtimek.cnt@hsp=50{

objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0

}
}



if@hsp ts.cnt@hsp=8{
objtimek.cnt@hsp+=1

gmode@hsp 5,,,150
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,4
gmode@hsp 2,,

if@hsp objtimek.cnt@hsp=20{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
}
}



if@hsp ts.cnt@hsp=15{
objtimek.cnt@hsp+=1

gmode@hsp 5,,,200
d3setcamx  0, 0, 450, 0, 0, 0
d3particle 2,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,20
gmode@hsp 2,,

if@hsp objtimek.cnt@hsp=10{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
tf.cnt@hsp=0:ts.cnt@hsp=0
txv.cnt@hsp=0
tyv.cnt@hsp=0
}
}



if@hsp ts.cnt@hsp=11{
objtimek.cnt@hsp+=1

color@hsp 0,0,0
gmode@hsp 4,,,100
gcopy@hsp 8,0,229,69,34
gmode@hsp 2,,

}

if@hsp ts.cnt@hsp=44{

gmode@hsp 2,199,120
gcopy@hsp 14,0,0,199,120
objtimek3.cnt@hsp+=1
if@hsp objtimek3.cnt@hsp>=50{
objtimek2.cnt@hsp+=1
tyv.cnt@hsp=0:txv.cnt@hsp=0
if@hsp objtimek2.cnt@hsp>=50{
objtimek.cnt@hsp+=1
if@hsp (180-objtimek.cnt@hsp*5)<=0:objtimek2.cnt@hsp=0:objtimek.cnt@hsp=0
target=cnt@hsp:spd=8:type=7			
if@hsp objtimek.cnt@hsp\40=0:gosub@hsp *uzudanmak
target=cnt@hsp:spd=10:type=0			
if@hsp objtimek.cnt@hsp\30=0:gosub@hsp *laser
target=0:spd=0:type=0
tyv.cnt@hsp=sina(89)/8
}
if@hsp dis.cnt@hsp>=1{
if@hsp zhp.cnt@hsp>=1:break@hsp
if@hsp dis.cnt@hsp=1:objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0:target=cnt@hsp:gosub@hsp *bosshit:target=0:dis.cnt@hsp+=1
objtimek.cnt@hsp+=1

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000



eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5

if@hsp objtimek.cnt@hsp>=5:objtimek.cnt@hsp=0:objtimek2.cnt@hsp+=1
objtimek3.cnt@hsp=(objtimek2.cnt@hsp+1)*64
gmode@hsp 2,64,64
gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-4,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-20,ty2.cnt@hsp-4:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp+30,ty2.cnt@hsp-40:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
pos@hsp tx2.cnt@hsp-10,ty2.cnt@hsp+20:gcopy@hsp 7,objtimek3.cnt@hsp,0,64,64
if@hsp objtimek2.cnt@hsp>9{
objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0

hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=20


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=9
gook+=1
}
}
}


}
if@hsp ts.cnt@hsp=45{

objtimek3.cnt@hsp+=1
if@hsp objtimek3.cnt@hsp>=15{
objtimek2.cnt@hsp+=1
tyv.cnt@hsp=0:txv.cnt@hsp=0
if@hsp objtimek2.cnt@hsp>=50{
objtimek.cnt@hsp+=1
if@hsp (180-objtimek.cnt@hsp*5)<=0:ds_play 12:objtimek2.cnt@hsp=0:objtimek.cnt@hsp=0
txv.cnt@hsp=cosa(180-objtimek.cnt@hsp*5)/8
tyv.cnt@hsp=sina(90)/8
}
}
gmode@hsp 2,143,25
gcopy@hsp 14,202,0,143,25
pos@hsp tx2.cnt@hsp,ty2.cnt@hsp+10
gmode@hsp 2,12,25

grotate@hsp 14,202,25,(3.14/4)-double@hsp(objtimek.cnt@hsp*16)/100,12,35
if@hsp dis(tc.cnt@hsp)>=1:dis.cnt@hsp=1
if@hsp dis.cnt@hsp=1:resetmove cnt@hsp,eh2.cnt@hsp,2:nohit cnt@hsp
}
if@hsp ts.cnt@hsp=46{
objtimek3.cnt@hsp+=1
if@hsp objtimek3.cnt@hsp>=50{
objtimek2.cnt@hsp+=1
tyv.cnt@hsp=0:txv.cnt@hsp=0
if@hsp objtimek2.cnt@hsp>=50{
objtimek.cnt@hsp+=1
if@hsp (objtimek.cnt@hsp*5)>=180:ds_play 12:objtimek2.cnt@hsp=0:objtimek.cnt@hsp=0:tyv.cnt@hsp=0
txv.cnt@hsp=cosa(objtimek.cnt@hsp*5)/8
tyv.cnt@hsp=sina(90)/8
}
}
gmode@hsp 2,145,25
grotate@hsp 14,202,0,3.14,135,25
pos@hsp tx2.cnt@hsp+60,ty2.cnt@hsp+5
gmode@hsp 2,12,25
grotate@hsp 14,202,25,-(3.14/4)+double@hsp(objtimek.cnt@hsp*16)/100,12,45
if@hsp dis(tc.cnt@hsp)>=1:dis.cnt@hsp=1
if@hsp dis.cnt@hsp=1:resetmove cnt@hsp,eh2.cnt@hsp,2:nohit cnt@hsp
}
if@hsp ts.cnt@hsp=47{
objtimek3.cnt@hsp+=1
if@hsp objtimek3.cnt@hsp>=65{
objtimek2.cnt@hsp+=1
tyv.cnt@hsp=0:txv.cnt@hsp=0
if@hsp objtimek2.cnt@hsp>=50{
objtimek.cnt@hsp+=1
if@hsp (180-objtimek.cnt@hsp*5)<=0:ds_play 12:objtimek2.cnt@hsp=0:objtimek.cnt@hsp=0
txv.cnt@hsp=cosa(180-objtimek.cnt@hsp*5)/8
tyv.cnt@hsp=sina(90)/8
}
}
gmode@hsp 2,143,25
gcopy@hsp 14,202,0,143,25
pos@hsp tx2.cnt@hsp,ty2.cnt@hsp+5
gmode@hsp 2,12,25
grotate@hsp 14,202,54,-(3.14/4)+double@hsp(objtimek.cnt@hsp*16)/100,12,45
if@hsp dis(tc.cnt@hsp)>=1:dis.cnt@hsp=1
if@hsp dis.cnt@hsp=1:resetmove cnt@hsp,eh2.cnt@hsp,2:nohit cnt@hsp

}
if@hsp ts.cnt@hsp=48{
objtimek3.cnt@hsp+=1
if@hsp objtimek3.cnt@hsp>=100{
objtimek2.cnt@hsp+=1
tyv.cnt@hsp=0:txv.cnt@hsp=0
if@hsp objtimek2.cnt@hsp>=50{
objtimek.cnt@hsp+=1
if@hsp (objtimek.cnt@hsp*5)>=180:ds_play 12:objtimek2.cnt@hsp=0:objtimek.cnt@hsp=0:tyv.cnt@hsp=0
txv.cnt@hsp=cosa(objtimek.cnt@hsp*5)/8
tyv.cnt@hsp=sina(90)/8
}
}
gmode@hsp 2,143,25
grotate@hsp 14,202,0,3.14,133,25
pos@hsp tx2.cnt@hsp+70,ty2.cnt@hsp-15
gmode@hsp 2,12,25
grotate@hsp 14,202,25,(3.14/4)-double@hsp(objtimek.cnt@hsp*16)/100,12,45
if@hsp dis(tc.cnt@hsp)>=1:dis.cnt@hsp=1
if@hsp dis.cnt@hsp=1:resetmove cnt@hsp,eh2.cnt@hsp,2:nohit cnt@hsp
}



if@hsp ts.cnt@hsp=41{
objtimek.cnt@hsp+=1

gmode@hsp 5,14,5,200
grotate@hsp 5,66,30,tk.cnt@hsp,4,10*objtimek.cnt@hsp

if@hsp objtimek.cnt@hsp>=50{
txv.cnt@hsp=0:tyv.cnt@hsp=0

}
if@hsp objtimek.cnt@hsp>=80{
tf.cnt@hsp=0:ts.cnt@hsp=0
}

}




if@hsp ts.cnt@hsp=28{
objtimek.cnt@hsp+=1

color@hsp 0,0,0

gmode@hsp 5,,,150
d3setcamx  0, 0, 450, 0, 0, 0
d3particle tc.cnt@hsp,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,7
gmode@hsp 2,,

}
if@hsp ts.cnt@hsp=29{
objtimek.cnt@hsp+=1

color@hsp 0,0,0

gmode@hsp 5,,,150
d3setcamx  0, 0, 450, 0, 0, 0
d3particle tc.cnt@hsp,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,3
gmode@hsp 2,,

}
if@hsp ts.cnt@hsp=30{
objtimek.cnt@hsp+=1

color@hsp 0,0,0

gmode@hsp 5,,,150
d3setcamx  0, 0, 450, 0, 0, 0
d3particle tc.cnt@hsp,-ty2.cnt@hsp+220,-tx2.cnt@hsp+220,0,20
gmode@hsp 2,,

}





if@hsp ts.cnt@hsp=4{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,12,18
gcopy@hsp 5,54,0,12,18
if@hsp objtimek.cnt@hsp<=10&objtimek.cnt@hsp>=1{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/objtimek.cnt@hsp
tyv.cnt@hsp=sina(eh2.cnt@hsp)/objtimek.cnt@hsp
}
if@hsp objtimek.cnt@hsp>11{
eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2
}

}else@hsp{

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
}
}







if@hsp ts.cnt@hsp=21{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,12,18
gcopy@hsp 5,18,75,32,27
if@hsp objtimek.cnt@hsp<=10&objtimek.cnt@hsp>=1{
eh2.cnt@hsp=270
txv.cnt@hsp=cosa(eh2.cnt@hsp)/objtimek.cnt@hsp
tyv.cnt@hsp=sina(eh2.cnt@hsp)/objtimek.cnt@hsp
}
if@hsp objtimek.cnt@hsp>20{
eh2.cnt@hsp=90
txv.cnt@hsp=cosa(eh2.cnt@hsp)/4 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/4
}

}else@hsp{

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
}
}

if@hsp ts.cnt@hsp=60{
if@hsp dis.cnt@hsp=0{
objtimek.cnt@hsp+=1
gmode@hsp 2,44,53
gcopy@hsp 17,0,0,44,53


}else@hsp{

hitchklenghx.cnt@hsp=-1000
hitchklenghy.cnt@hsp=-1000


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000

objtimek.cnt@hsp=0:objtimek2.cnt@hsp=0:objtimek3.cnt@hsp=0
ts.cnt@hsp=0:dis.cnt@hsp=0
}
}
loop@hsp

repeat@hsp maxdansu
if@hsp shotf.cnt@hsp<1 :continue@hsp						
if@hsp shotf.cnt@hsp=1{
shoty.cnt@hsp+=shotyv.cnt@hsp
shotx.cnt@hsp+=shotxv.cnt@hsp
shotx2.cnt@hsp=shotx.cnt@hsp/1000
shoty2.cnt@hsp=shoty.cnt@hsp/1000
shotcx.cnt@hsp=shotx2.cnt@hsp+1
shotcy.cnt@hsp=shoty2.cnt@hsp+11

pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,2,22:gcopy@hsp 5,0,0,2,22

if@hsp wapon2kaun>=550 & sens=1{
repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=50|ts.cnt@hsp=55{
targets=cnt@hsp
break@hsp
}
loop@hsp
getsankak2 targets,cnt@hsp
eh3.cnt@hsp=b
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)/1 : shotyv.cnt@hsp=sina(eh3.cnt@hsp)/1
}

if@hsp (shotx2.cnt@hsp>355)|(shotx2.cnt@hsp<-50)|(shoty2.cnt@hsp<-50)|(shoty2.cnt@hsp>500) {
shotf.cnt@hsp=0
continue@hsp
}
if@hsp shotdis.cnt@hsp=1{
shotf.cnt@hsp=0
shotdis.cnt@hsp=0
shotx2.cnt@hsp=0
shoty2.cnt@hsp=0
shotcx.cnt@hsp=0
shotcy.cnt@hsp=0
}
}

if@hsp shotf.cnt@hsp=2{
shottimek.cnt@hsp+=1
kaiten+=1
shoty.cnt@hsp+=shotyv.cnt@hsp
shotx.cnt@hsp+=shotxv.cnt@hsp
shotx2.cnt@hsp=shotx.cnt@hsp/1000
shoty2.cnt@hsp=shoty.cnt@hsp/1000
shotcx.cnt@hsp=shotx2.cnt@hsp+1
shotcy.cnt@hsp=shoty2.cnt@hsp+11

if@hsp shottimek.cnt@hsp<=10&shottimek.cnt@hsp>=0{

pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34

}
if@hsp shottimek.cnt@hsp<=50&shottimek.cnt@hsp>=11{

shoty.cnt@hsp-=shotyv.cnt@hsp
shotx.cnt@hsp-=shotxv.cnt@hsp
pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34
target=cnt@hsp
gosub@hsp *spark_on
target=0

}
if@hsp shottimek.cnt@hsp<=100&shottimek.cnt@hsp>=50{
repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp

if@hsp ts.cnt@hsp=1|ts.cnt@hsp=6|ts.cnt@hsp=5|ts.cnt@hsp=9|ts.cnt@hsp=12|ts.cnt@hsp=14{

targets=cnt@hsp
break@hsp
}
if@hsp ts.cnt@hsp=17|ts.cnt@hsp=18|ts.cnt@hsp=22|ts.cnt@hsp=23|ts.cnt@hsp=25|ts.cnt@hsp=31|ts.cnt@hsp=32|ts.cnt@hsp=33|ts.cnt@hsp=36|ts.cnt@hsp=38|ts.cnt@hsp=39|ts.cnt@hsp=40|ts.cnt@hsp=50|ts.cnt@hsp=55{
targets=cnt@hsp
break@hsp
}
loop@hsp

getsankak2 targets,cnt@hsp

eh3.cnt@hsp=b
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp

pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34
target=cnt@hsp
gosub@hsp *spark_on
target=0
}
if@hsp shottimek.cnt@hsp>=100{
pos@hsp shotx2.cnt@hsp,shoty2.cnt@hsp
gmode@hsp 2,34,34:grotate@hsp 5,0,27,kaiten,34,34
}
if@hsp (shotx2.cnt@hsp>540)|(shotx2.cnt@hsp<-150)|(shoty2.cnt@hsp<-150)|(shoty2.cnt@hsp>550) {
shotf.cnt@hsp=0
shotdis.cnt@hsp=1
shotx2.cnt@hsp=0
shoty2.cnt@hsp=0
shotcx.cnt@hsp=0
shotcy.cnt@hsp=0
shotxv.cnt@hsp=0 : shotyv.cnt@hsp=0
eh3.cnt@hsp=0
shottimek.cnt@hsp=0
continue@hsp
}
}

if@hsp shotf.cnt@hsp=3{
shottimek.cnt@hsp+=1

shoty.cnt@hsp+=shotyv.cnt@hsp
shotx.cnt@hsp+=shotxv.cnt@hsp
shotx2.cnt@hsp=shotx.cnt@hsp/1000
shoty2.cnt@hsp=shoty.cnt@hsp/1000
shotcx.cnt@hsp=shotx2.cnt@hsp+1
shotcy.cnt@hsp=shoty2.cnt@hsp+11

if@hsp shottimek.cnt@hsp<=10&shottimek.cnt@hsp>=0{

gmode@hsp 5,,,255:d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-shoty2.cnt@hsp+220,-shotx2.cnt@hsp+220,0,10

}
if@hsp shottimek.cnt@hsp<=50&shottimek.cnt@hsp>=11{

shoty.cnt@hsp-=shotyv.cnt@hsp
shotx.cnt@hsp-=shotxv.cnt@hsp
gmode@hsp 5,,,255:d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-shoty2.cnt@hsp+220,-shotx2.cnt@hsp+220,0,10


}
if@hsp shottimek.cnt@hsp<=100&shottimek.cnt@hsp>=50{
repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=1|ts.cnt@hsp=6|ts.cnt@hsp=5|ts.cnt@hsp=9|ts.cnt@hsp=12|ts.cnt@hsp=14{
targets=cnt@hsp
break@hsp
}

loop@hsp

getsankak2 target
eh3.cnt@hsp=b
shotxv.cnt@hsp=cosa(eh3.cnt@hsp)*sp : shotyv.cnt@hsp=sina(eh3.cnt@hsp)*sp

gmode@hsp 5,,,255:d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-shoty2.cnt@hsp+220,-shotx2.cnt@hsp+220,0,10

}
if@hsp shottimek.cnt@hsp>=100{
gmode@hsp 5,,,255:d3setcamx  0, 0, 450, 0, 0, 0
d3particle 1,-shoty2.cnt@hsp+220,-shotx2.cnt@hsp+220,0,10
}
if@hsp (shotx2.cnt@hsp>440)|(shotx2.cnt@hsp<-150)|(shoty2.cnt@hsp<-150)|(shoty2.cnt@hsp>550) {
shotf.cnt@hsp=0
shotdis.cnt@hsp=0
shotx2.cnt@hsp=0
shoty2.cnt@hsp=0
shotcx.cnt@hsp=0
shotcy.cnt@hsp=0
shotxv.cnt@hsp=0 : shotyv.cnt@hsp=0
eh3.cnt@hsp=0
shottimek.cnt@hsp=0
continue@hsp
}
}
loop@hsp


return@hsp
*hitchk


if@hsp shotdasuna=1:return@hsp
if@hsp mutekif=1:return@hsp
yhit=0:xhit=0
ykasuri=0:xkasuri=0

repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=3:continue@hsp

yhit=0:xhit=0
ykasuri=0:xkasuri=0

if@hsp drawhantei=1{
color@hsp 255,0,0
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp+hitchklenghx.cnt@hsp,tcy.cnt@hsp+hitchklenghy.cnt@hsp
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp+hitchklenghx.cnt@hsp,tcy.cnt@hsp-hitchklenghy.cnt@hsp
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp-hitchklenghx.cnt@hsp,tcy.cnt@hsp+hitchklenghy.cnt@hsp
boxf@hsp tcx.cnt@hsp,tcy.cnt@hsp,tcx.cnt@hsp-hitchklenghx.cnt@hsp,tcy.cnt@hsp+hitchklenghy.cnt@hsp
}



kyoriy=tcy.cnt@hsp-mycharcentery
kyorix=tcx.cnt@hsp-mycharcenterx

kyoriy=abs@hsp(kyoriy)
kyorix=abs@hsp(kyorix)

if@hsp kyoriy<mycharuppery+hitchklenghy.cnt@hsp:yhit=1
if@hsp kyorix<mycharrightx+hitchklenghx.cnt@hsp:xhit=1
if@hsp kyoriy<kasury+hitchklenghy.cnt@hsp:ykasuri=1
if@hsp kyorix<kasurx+hitchklenghx.cnt@hsp:xkasuri=1

if@hsp ykasuri+xkasuri=2{
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13|ts.cnt@hsp=19|ts.cnt@hsp=20|ts.cnt@hsp=24|ts.cnt@hsp=26|ts.cnt@hsp=27|ts.cnt@hsp=37|ts.cnt@hsp=43{
score+=1:kasurikaunter+=1
gosub@hsp *kasuri_on
}
}

if@hsp yhit+xhit=2{
if@hsp ts.cnt@hsp=60{
goto@hsp *stagecla3
}

if@hsp ts.cnt@hsp=1|ts.cnt@hsp=5|ts.cnt@hsp=9|ts.cnt@hsp=16|ts.cnt@hsp=14|ts.cnt@hsp=17|ts.cnt@hsp=22|ts.cnt@hsp=31|ts.cnt@hsp=32|ts.cnt@hsp=33|ts.cnt@hsp=36{
if@hsp mutekif>=2:break@hsp
dis.cnt@hsp=1		
gosub@hsp *mycharhit	
}
if@hsp ts.cnt@hsp=6|ts.cnt@hsp=12|ts.cnt@hsp=25|ts.cnt@hsp=39|ts.cnt@hsp=40|ts.cnt@hsp=44|ts.cnt@hsp=45|ts.cnt@hsp=46|ts.cnt@hsp=47|ts.cnt@hsp=48|ts.cnt@hsp=50{
if@hsp mutekif>=2:break@hsp	
gosub@hsp *mycharhit	
}
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13|ts.cnt@hsp=19|ts.cnt@hsp=20|ts.cnt@hsp=24|ts.cnt@hsp=26|ts.cnt@hsp=27|ts.cnt@hsp=37|ts.cnt@hsp=43{
if@hsp mutekif>=2:break@hsp
gosub@hsp *mycharhit	
}
if@hsp ts.cnt@hsp=4{			
shotpower+=1:score+=100
dis.cnt@hsp=1:ds_play 5
}	
if@hsp ts.cnt@hsp=21{
life+=1:score+=1000
dis.cnt@hsp=1:ds_play 7
}
}

shotatatta=0
if@hsp ts.cnt@hsp=1|ts.cnt@hsp=5|ts.cnt@hsp=6|ts.cnt@hsp=9|ts.cnt@hsp=12|ts.cnt@hsp=14		:shotatatta=1
if@hsp ts.cnt@hsp=16|ts.cnt@hsp=17|ts.cnt@hsp=18|ts.cnt@hsp=22|ts.cnt@hsp=23|ts.cnt@hsp=25	:shotatatta=1
if@hsp ts.cnt@hsp=31|ts.cnt@hsp=32|ts.cnt@hsp=33|ts.cnt@hsp=36|ts.cnt@hsp=38|ts.cnt@hsp=39	:shotatatta=1
if@hsp ts.cnt@hsp=40|ts.cnt@hsp=44|ts.cnt@hsp=50|ts.cnt@hsp=55:shotatatta=1

if@hsp shotatatta=1{
target=cnt@hsp
repeat@hsp maxdansu

if@hsp shotf.cnt@hsp<1:continue@hsp

yhit2=0:xhit2=0

kyoriy2=tcy.target-shotcy.cnt@hsp
kyorix2=tcx.target-shotcx.cnt@hsp

kyoriy2=abs@hsp(kyoriy2)
kyorix2=abs@hsp(kyorix2)

if@hsp kyoriy2<shothity+hitchklenghy.target:yhit2=1
if@hsp kyorix2<shothitx+hitchklenghx.target:xhit2=1

if@hsp yhit2+xhit2=2{

if@hsp ts.target=1|ts.target=5|ts.target=9|ts.target=16|ts.target=17|ts.target=22{

hitchklenghx.target=-1000
hitchklenghy.target=-1000


tcplusx.target=-1000
tcplusy.target=-1000

ds_play 2 
score+=100
dis.target=1:shotdis.cnt@hsp=1
}

if@hsp ts.target=6|ts.target=18|ts.target=39{
score+=100:shotdis.cnt@hsp=1
chp-=1:ds_play 2

if@hsp ts.target=6{
pos@hsp tx2.target-4,ty2.target-4
gcopy@hsp 7,63,0,64,64
}
if@hsp ts.target=18|ts.target=39:gosub@hsp *damage_on

if@hsp chp<=0:dis.target=1
}
if@hsp ts.target=23{
score+=100:shotdis.cnt@hsp=1
zhp.target-=1:ds_play 2
gosub@hsp *damage_on
if@hsp zhp.target<=0:dis.target=1:disbullet(10)
}
oscs=0
if@hsp ts.target=31|ts.target=32|ts.target=33:oscs=1
if@hsp ts.target=36|ts.target=38|ts.target=40:oscs=1
if@hsp ts.target=44|ts.target=50|ts.target=55:oscs=1
if@hsp oscs=1{
if@hsp wapon2kaun>=550 & sens=1|kg=1|kg2=1:break@hsp
score+=100:shotdis.cnt@hsp=1
zhp.target-=1:ds_play 2
gosub@hsp *damage_on
if@hsp zhp.target<=0:dis.target=1
}
if@hsp ts.target=12|ts.target=25{
score+=100:shotdis.cnt@hsp=1
zhp.target-=1
ds_play 2

gosub@hsp *damage_on


if@hsp zhp.target<=0:dis.target=1:gosub@hsp *bosshit
}
if@hsp ts.target=14{
score+=100:shotdis.cnt@hsp=1
fhp.target-=1
ds_play 2

gosub@hsp *damage_on


if@hsp fhp.target<=0:dis.target=1
}
}
loop@hsp	
}
loop@hsp



return@hsp
*mycharhit

ds_play 3
if@hsp mutekif>=1:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=(eh-1)*10+(pt*5) : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=3


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(mx+20)*1000 :ty.cnt@hsp=my*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=36 : eh=0 : break@hsp							
loop@hsp

life-=1
my+=1000
mutekif=1

disbullet(10)		

return@hsp
*kasuri_on
yobareta3+=1
if@hsp yobareta3>=10:yobareta3=0
if@hsp yobareta3>=2:return@hsp

ds_play 6

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
rand=rnd@hsp(360)
eh2.cnt@hsp=rand : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=8


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(mx+20)*1000 :ty.cnt@hsp=my*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

return@hsp
*spark_on

return@hsp
yobareta+=1
if@hsp yobareta>=10:yobareta=0
if@hsp yobareta>=2:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
rand=rnd@hsp(360)
eh2.cnt@hsp=rand : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=8


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(shotx2.target+20)*1000 :ty.cnt@hsp=shoty2.target*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp



return@hsp
*damage_on

yobareta2+=1
if@hsp yobareta2>=5:yobareta2=0
if@hsp yobareta2>=2:return@hsp

repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
rand=rnd@hsp(360)
eh2.cnt@hsp=rand : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=15


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(tcx.target)*1000 :ty.cnt@hsp=tcy.target*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/2 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/2	
if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp



return@hsp
*bosshit

yobareta+=1
if@hsp yobareta>=2:return@hsp
repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=(eh-1)*10+(pt*5) : if@hsp eh2>359 : eh2-=360	
tf.cnt@hsp=1										
ts.cnt@hsp=35


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=0
tcplusy.cnt@hsp=0

tc.cnt@hsp=255										
tx.cnt@hsp=(tcx.target+20)*1000 :ty.cnt@hsp=tcy.target*1000				
txv.cnt@hsp=cosa(eh2.cnt@hsp)/3 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/3	
if@hsp eh=36 : eh=0 : break@hsp							
loop@hsp


disbullet(10)


return@hsp
*sleeping

noteget@hsp par,1
par=int@hsp(par)

if@hsp kauntpar>=par{
kauntpar=0:turn+=1
}

kauntpar+=1
return@hsp
*teisi

if@hsp fantao=6:fantao=0:turn+=1
if@hsp gook >=1 :turn+=1:gook=0
return@hsp
*teisi2

if@hsp (gook >= 5) : turn += 1 : gook = 0
return@hsp
*disall
repeat@hsp tmax
if@hsp tf.cnt@hsp<1:continue@hsp
if@hsp ts.cnt@hsp=2|ts.cnt@hsp=7|ts.cnt@hsp=10|ts.cnt@hsp=13{

tf.cnt@hsp=0 
ts.cnt@hsp=0
dis.cnt@hsp=0


hitchklenghx.cnt@hsp=0
hitchklenghy.cnt@hsp=0


tcplusx.cnt@hsp=-1000
tcplusy.cnt@hsp=-1000
}


loop@hsp

return@hsp
*q_continue
if@hsp maxcont-cont<=0:goto@hsp *gameov
repeat@hsp
redraw@hsp 1:await@hsp 0:redraw@hsp 2
pos@hsp 125,200:color@hsp 255,255,255
font@hsp "MS ゴシック",25
mes@hsp "Continue? Y or N"
pos@hsp 124,198
color@hsp 0,0,0
mes@hsp "Continue? Y or N"
font@hsp "MS gosic",20
mes@hsp "のこり"+(maxcont-cont)+"回"
getkey@hsp keyon,89
getkey@hsp keyon2,78
if@hsp keyon=1:cls@hsp:life=4:cont+=1:goto@hsp *mainloop
if@hsp keyon2=1:goto@hsp *gameov
loop@hsp

*gameclear
cls@hsp
dmstop
mmstop@hsp
picload@hsp "img/kuria.GIF"
color@hsp 255,0,0
mes@hsp "ゲームクリア！！"
mmplay@hsp 10
goto@hsp *cl

*gameov
cls@hsp 
dmstop
mmstop@hsp
picload@hsp "img/dore.GIF"
color@hsp 255,0,0
mes@hsp "ゲームおーばー"

dmplay 10,5
*cl
mes@hsp
if@hsp cont>=1:mes@hsp "コンチィニューしているのでリプレイは保存できません":button@hsp "戻る",*no:stop@hsp
if@hsp replayf=1:replayf=0:button@hsp "戻る",*top:stop@hsp
mes@hsp "リプレイを保存しますか？"
button@hsp "ＯＫ",*ok:button@hsp "NO",*no

pos@hsp 200,100

stop@hsp
*ok
mes@hsp "リプレイの名前を入れてください"
input@hsp replayname:button@hsp "保存",*hozon
stop@hsp
*hozon
objprm@hsp 3,replayname
dialog@hsp replayname+"を/replayに保存しました"
bsave@hsp "replay/"+replayname+".rep",replay
end@hsp
stop@hsp
*no
dialog@hsp "ほんとうに終了しますか？",2
if@hsp stat@hsp=6:end@hsp
if@hsp stat@hsp=7:cls@hsp:pos@hsp 0,0:goto@hsp *cl
stop@hsp
*replayload
cls@hsp
color@hsp 0,0,0

dirlist@hsp clent,"replay/*.rep"
notesel@hsp clent
repeat@hsp  noteinfo@hsp(0)

noteget@hsp filename.cnt@hsp,cnt@hsp
mes@hsp filename.cnt@hsp

loop@hsp

objsize@hsp 100,32:combox@hsp choice,,clent
button@hsp "ロードする",*replayload2
button@hsp "もどる",*clsa
stop@hsp
*replayload2
bload@hsp "replay/"+filename.choice,replay,30000


replayf=1:life=4
goto@hsp *stagestart2


*endo

end@hsp
*stagecla1
color@hsp 0,0,0
boxf@hsp 0,0,box+20,440
box+=20

if@hsp box>=440{
cls@hsp 4
goukei=score+(kasurikaunter*100)+(heikinfps)
color@hsp 255,255,255
font@hsp "MS　ゴシック",20
mes@hsp "CLEAR STAGE!\n"
font@hsp "MS ゴシック",15
mes@hsp "\t敵弾カスリ:\t"+kasurikaunter+"×100\t=\t"+kasurikaunter*100
mes@hsp "\tゲームスピード:\t"+heikinfps/1000+"×1000\t=\t"+heikinfps
mes@hsp "\t合計:\t\t\t\t"+goukei
mes@hsp
mes@hsp "\tEnter to Go Next Stage"
repeat@hsp
await@hsp 0
stick@hsp keyon,32
if@hsp keyon&32{

cls@hsp:stage=2:turn=0:titlex=0:bos=0:goto@hsp *stagestart2
}
loop@hsp

}

return@hsp
*stagecla2
color@hsp 0,0,0
boxf@hsp 0,0,box+20,440
box+=20

if@hsp box>=440{
cls@hsp 4
goukei=score+(kasurikaunter*100)+(heikinfps)
color@hsp 255,255,255
font@hsp "MS　ゴシック",20
mes@hsp "CLEAR STAGE!\n"
font@hsp "MS ゴシック",15
mes@hsp "\t敵弾カスリ:\t"+kasurikaunter+"×100\t=\t"+kasurikaunter*100
mes@hsp "\tゲームスピード:\t"+heikinfps/1000+"×1000\t=\t"+heikinfps
mes@hsp "\t合計:\t\t\t\t"+goukei
mes@hsp
mes@hsp "\tEnter to Go Next Stage"
repeat@hsp
await@hsp 0
stick@hsp keyon,32

if@hsp keyon&32:cls@hsp:stage=3:turn=0:titlex=0:bos=0:goto@hsp *stagestart2
loop@hsp

}

return@hsp
*stagecla3
color@hsp 0,0,0
boxf@hsp 0,0,box+20,440
box+=20

if@hsp box>=440{
cls@hsp 4
goukei=score+(kasurikaunter*100)+(heikinfps)
color@hsp 255,255,255
font@hsp "MS　ゴシック",20
mes@hsp "CLEAR STAGE!\n"
font@hsp "MS ゴシック",15
mes@hsp "\t敵弾カスリ:\t"+kasurikaunter+"×100\t=\t"+kasurikaunter*100
mes@hsp "\tゲームスピード:\t"+heikinfps/1000+"×1000\t=\t"+heikinfps
mes@hsp "\t合計:\t\t\t\t"+goukei
mes@hsp
mes@hsp "\tEnter to Save Replay"
repeat@hsp
await@hsp 0
stick@hsp keyon,32
if@hsp keyon&32{

cls@hsp:stage=4:turn=0:titlex=0:bos=0:cls@hsp:goto@hsp *gameclear
}
loop@hsp

}

return@hsp
*stage3loop

ct++
frame+=1
redraw@hsp 0



gosub@hsp *backg_screen
color@hsp 0,0,0
boxf@hsp 350,0,440,440

gosub@hsp *write_stage
gosub@hsp *keychk

gosub@hsp *write_status
gosub@hsp *write_mychar
gosub@hsp *put_shot
gosub@hsp *call_enemy

gosub@hsp *object_move

if@hsp hissatuf=1:gosub@hsp *moreta_wapon
if@hsp hissatuf=2:gosub@hsp *moreta_wapon2
if@hsp morerl=1:gosub@hsp *moreta_wapon2_2

if@hsp drawhantei=1{
color@hsp 255, 0, 0
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx+mycharuppery, mycharcentery+mycharrightx
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx+mycharuppery, mycharcentery-mycharrightx
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx-mycharuppery, mycharcentery-mycharrightx
boxf@hsp mycharcenterx, mycharcentery, mycharcenterx-mycharuppery, mycharcentery+mycharrightx
}

gosub@hsp *hitchk
redraw@hsp 1


fps=d3getfps()
sumfps+=fps
heikinfps=(sumfps/frame)*1000

if@hsp waitkaunt<=0.0:waitkaunt=0.0

mm_await waitkaunt
await@hsp 1


goto@hsp *stage3loop
*kanzenexit
end@hsp
*sen1
noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp ehp,3
sens=1



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=50										
zhp.cnt@hsp=int@hsp(ehp)

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=40


tcplusx.cnt@hsp=20
tcplusy.cnt@hsp=40

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*sen2
noteget@hsp exa,1
noteget@hsp eya,2
noteget@hsp ehp,3
sens=1



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=90										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=55										
zhp.cnt@hsp=int@hsp(ehp)

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=40


tcplusx.cnt@hsp=20
tcplusy.cnt@hsp=40

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
*vman3
noteget@hsp exa,1
noteget@hsp eya,2



repeat@hsp tmax
if@hsp tf.cnt@hsp>0 {continue@hsp} if@hsp dis.cnt@hsp>0 {continue@hsp}							
eh+
eh2.cnt@hsp=180										
tf.cnt@hsp=1										
tc.cnt@hsp=255										

ts.cnt@hsp=51										

tx.cnt@hsp=int@hsp(exa)*1000 :ty.cnt@hsp=int@hsp(eya)*1000			
txv.cnt@hsp=cosa(eh2.cnt@hsp)/5 : tyv.cnt@hsp=sina(eh2.cnt@hsp)/5	


hitchklenghx.cnt@hsp=20
hitchklenghy.cnt@hsp=40


tcplusx.cnt@hsp=20
tcplusy.cnt@hsp=40

if@hsp eh=1 : eh=0 : break@hsp							
loop@hsp

turn+=1

return@hsp
