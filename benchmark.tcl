#!/usr/bin/env tclsh
namespace eval benchmark {
    variable tclssg {../ssg.tcl}
    variable benchmarks [list benchmark1]
}

proc ::benchmark::run-tclssg {prefix command args} {
    variable tclssg
    exec -ignorestderr -- {*}$prefix $tclssg $command {*}$args
}

proc ::benchmark::main {} {
    variable benchmarks
    puts "Tclssg version tested: [run-tclssg {} version]"
    foreach benchmark $benchmarks {
        for {set i 0} {$i < 3} {incr i} {
            run-tclssg time build [file join $benchmark input] > /dev/null
        }
        for {set i 0} {$i < 3} {incr i} {
            run-tclssg memusg build [file join $benchmark input] > /dev/null
        }
    }
}

::benchmark::main
