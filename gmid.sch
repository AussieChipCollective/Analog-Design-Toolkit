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
N 40 -55 40 -30 {lab=#net1}
N 40 -120 40 -115 {lab=Vd}
C {vsource.sym} -80 50 0 0 {name=V1 value=Vg savecurrent=false}
C {vsource.sym} -180 50 0 0 {name=V2 value=1.5 savecurrent=false}
C {gnd.sym} -80 100 0 0 {name=l1 lab=GND}
C {gnd.sym} -180 100 0 0 {name=l2 lab=GND}
C {gnd.sym} 40 55 0 0 {name=l3 lab=GND}
C {gnd.sym} 160 60 0 0 {name=l4 lab=GND}
C {lab_wire.sym} -110 -120 0 0 {name=p2 sig_type=std_logic lab=Vd
}
C {lab_wire.sym} -30 0 0 0 {name=p1 sig_type=std_logic lab=Vg}
C {sky130_fd_pr/nfet_01v8.sym} 20 0 0 0 {name=M2
L=L
W=10  
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {ammeter.sym} 40 -85 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {sky130_fd_pr/corner.sym} -170 -605 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/code_shown.sym} -762.5 -828.75 0 0 {name="GMOVERID BENCH"
only_toplevel=true
value="
.options savecurrents
.save all

* Parameters to sweep
.param L = 0.2
.param Vd = 1.5
.param Vg = 0

* Control block to sweep Vg for every L and Vd
.control

compose lvalues start=0.2 stop=1.0 step=0.2

set plotgmid = ' '
set plotft = ' '
set plotf3db = ' '
set plotav = ' '
set plotcd = ' '

foreach L $&lvalues
  alterparam L = $L
  reset  
  dc V1 0 1.5 10m

  * Extract device parameters
  let id = i(vmeas)
  let W = @m.xm2.msky130_fd_pr__nfet_01v8[W]
  let gm = @m.xm2.msky130_fd_pr__nfet_01v8[gm]
  let cgg = @m.xm2.msky130_fd_pr__nfet_01v8[cgg]
  let gds = @m.xm2.msky130_fd_pr__nfet_01v8[gds]
  let cds = @m.xm2.msky130_fd_pr__nfet_01v8[cds]

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
.save @m.xm2.msky130_fd_pr__nfet_01v8[gds]
.save @m.xm2.msky130_fd_pr__nfet_01v8[cgg]
.save @m.xm2.msky130_fd_pr__nfet_01v8[cds]
.save @m.xm2.msky130_fd_pr__nfet_01v8[gm]
.save @m.xm2.msky130_fd_pr__nfet_01v8[W] 
"}
