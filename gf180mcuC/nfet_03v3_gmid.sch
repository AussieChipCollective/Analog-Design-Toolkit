v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -180 80 -180 100 {lab=GND}
N -80 75 -80 100 {lab=GND}
N -80 -0 -80 20 {lab=Vg}
N -80 -0 0 -0 {lab=Vg}
N -180 -120 40 -120 {lab=Vd
}
N -180 -120 -180 20 {lab=Vd}
N 40 30 40 55 {lab=GND}
N 160 0 160 60 {lab=GND}
N 40 -0 160 -0 {lab=GND}
N 40 -60 40 -30 {lab=#net1}
N 40 -120 40 -110 {lab=Vd}
C {devices/code_shown.sym} -762.5 -828.75 0 0 {name="GMOVERID BENCH"
only_toplevel=true
value="
.options savecurrents
.save all

* Parameters to sweep
.param L = 0.3u
.param Vd = 3.3
.param Vg = 0

* Control block to sweep Vg for every L and Vd
.control

compose lvalues start=0.3u stop=1.8u step=0.3u

set plotgmid = ' '
set plotft = ' '
set plotf3db = ' '
set plotav = ' '
set plotcd = ' '

foreach L $&lvalues
  alterparam L = $L
  reset  
  dc V1 0 3.3 0.01

  * Extract device parameters
  let id = i(vmeas)
  let W = @m.xm1.m0[W]
  let gm = @m.xm1.m0[gm]
  let cgg = @m.xm1.m0[cgg]
  let gds = @m.xm1.m0[gds]
  let cds = @m.xm1.m0[cds]

  * Compute metrics
  let gmoverid = deriv(ln(id))
  let ft = (gm / cgg) * (1 / 6.28318530718)
  let f3db = (gds / cds) * ( 1 / 6.28318530718)
  let av = gm / gds
  let cd = id / W

  set plotgmid = ( $plotgmid \{$curplot\}.gmoverid ) 
  set plotft = ( $plotft \{$curplot\}.ft ) 
  set plotf3db = ( $plotf3db \{$curplot\}.f3db ) 
  set plotav = ( $plotav \{$curplot\}.av ) 
  set plotcd = ( $plotcd \{$curplot\}.cd ) 

  save gmoverid ft f3db av cd
  write gmid.raw
  set appendwrite

end

plot $plotft vs gmoverid ylog
plot $3dbplot vs gmoverid ylog
plot $plotav vs gmoverid
plot $plotcd vs gmoverid

.endc
"}
C {devices/code_shown.sym} -162.5 -828.75 0 0 {name="SAVE SETTINGS"
only_toplevel=true
value="
.options savecurrents
.save all
.save Vd Vg
.save @m.xm1.m0[gds]
.save @m.xm1.m0[cgg]
.save @m.xm1.m0[cds]
.save @m.xm1.m0[gm]
.save @m.xm1.m0[W] 
"}
C {devices/gnd.sym} 160 60 0 0 {name=l5 lab=GND}
C {devices/gnd.sym} -80 100 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} -180 100 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 40 50 0 0 {name=l4 lab=GND}
C {symbols/nfet_03v3.sym} 20 0 0 0 {name=M1
L=L
W=0.22u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {devices/vsource.sym} -80 50 0 0 {name=V1 value=Vg savecurrent=false}
C {devices/vsource.sym} -180 50 0 0 {name=V2 value=Vd savecurrent=false}
C {devices/lab_wire.sym} -50 0 0 0 {name=p1 sig_type=std_logic lab=Vg}
C {devices/lab_wire.sym} -110 -120 0 0 {name=p2 sig_type=std_logic lab=Vd}
C {devices/ammeter.sym} 40 -80 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {devices/code_shown.sym} -160 -600 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include /foss/pdks/gf180mcuC/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuC/libs.tech/ngspice/sm141064.ngspice typical
"}
