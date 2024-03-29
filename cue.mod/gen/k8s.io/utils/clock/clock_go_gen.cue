// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/utils/clock --exclude=yellowColor

package clock

// PassiveClock allows for injecting fake or real clocks into code
// that needs to read the current time but does not support scheduling
// activity in the future.
#PassiveClock: _

// Clock allows for injecting fake or real clocks into code that
// needs to do arbitrary things based on time.
#Clock: _

// WithTicker allows for injecting fake or real clocks into code that
// needs to do arbitrary things based on time.
#WithTicker: _

// WithDelayedExecution allows for injecting fake or real clocks into
// code that needs to make use of AfterFunc functionality.
#WithDelayedExecution: _

// WithTickerAndDelayedExecution allows for injecting fake or real clocks
// into code that needs Ticker and AfterFunc functionality
#WithTickerAndDelayedExecution: _

// Ticker defines the Ticker interface.
#Ticker: _

// RealClock really calls time.Now()
#RealClock: {
}

// Timer allows for injecting fake or real timers into code that
// needs to do arbitrary things based on time.
#Timer: _
