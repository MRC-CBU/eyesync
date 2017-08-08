This repo provides code for interfacing with SMI eye trackers. For further
documentation of the CBU eye tracking setup, see the [CBU imaging
wiki](http://imaging.mrc-cbu.cam.ac.uk/meg/EyeTracking).

# Matlab (serial port communication)
For a high-level calibration script, see
[eyeTrackerCalibration.m](eyeTrackerCalibration.m).

For complete documentation, see [this wiki
entry](http://imaging.mrc-cbu.cam.ac.uk/meg/EyeTrackingWithMatlab).

# Matlab (ethernet communication)
Please note that the code above is somewhat outdated - the release of the [SMI
Matlab
SDK](https://uk.mathworks.com/products/connections/product_detail/product_119541.html)
makes interfacing with the eye tracker much easier (and enables ethernet
communication, which is much preferable to the serial port connection these
tools uses). Advanced users may prefer to use the SMI tools instead.

# E-Prime
We use SMI's SDK. See [this wiki entry](http://imaging.mrc-cbu.cam.ac.uk/meg/EyeTrackingWithEprime).

# Others
Presentation should also work - again there is an SMI SDK.
