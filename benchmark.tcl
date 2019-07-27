#! /usr/bin/env tclsh
namespace eval benchmark {
    variable tclssg [expr {
        [info exists ::env(TCLSSG)] ?
        $::env(TCLSSG) :
        {../tclssg/ssg.tcl}
    }]
    variable benchmarks [list benchmark1]
}

proc ::benchmark::run args {
    puts "> $args"
    exec -ignorestderr -- {*}$args >@ stdout
}

proc ::benchmark::main {} {
    variable benchmarks
    variable tclssg

    run $tclssg version
    foreach benchmark $benchmarks {
        for {set i 0} {$i < 3} {incr i} {
            # You need GNU time(1) for the "-v" flag.
            run time -v $tclssg build [file join $benchmark input] |& \
                awk {/(time|CPU|set size)/}
        }
    }
}

::benchmark::main
