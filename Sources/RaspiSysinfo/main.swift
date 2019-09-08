

// =============================

extension CLResult {
    
    func resultToString() -> String {
        var resStr: String = "--- \(title) ---\n";
        
        for item in result {
            resStr += "\(item.key): \(item.value)"
        }
        resStr += "\n------------\n"
        return resStr
    }
    
}

// =============================

let raspiCL = RaspiVCGenCMD()


print(">>> \(raspiCL.ls().resultToString())")
print(">>> \(raspiCL.uptime().resultToString())")
print(">>> \(raspiCL.version().resultToString())")
print(">>> \(raspiCL.getLcdInfo().resultToString())")
print(">>> \(raspiCL.measureClock().resultToString())")
print(">>> \(raspiCL.measureTemp().resultToString())")
print(">>> \(raspiCL.measureVolts().resultToString())")
print(">>> \(raspiCL.codecEnabled().resultToString())")
print(">>> \(raspiCL.getMem().resultToString())")


