
import Foundation

class RaspiVCGenCMD {
    
    // /opt/vc/bin/vcgencmd  /usr/bin/vcgencmd
    private let vcgencmd: String = "/opt/vc/bin/vcgencmd"

    private let defaultResolver: CLResolver = DefaultResolver()
    
    init() {
//        self.cmdLS0 = Command(launchPath: "/bin/ls", cmd: "ls",
//                              options: ["-l"],
//                              resolver: defaultResolver)

    }
    
    func ls() -> CLResult {
        return Command(cmd: "/bin/ls",
                       options: ["-l"],
                       resolver: defaultResolver)
            .doCommand()
    }
    
    func version() -> CLResult {
        return Command(cmd: vcgencmd,
                       options: ["version"],
                       resolver: defaultResolver)
            .doCommand()
    }
    
    func uptime() -> CLResult {
        return Command(cmd: "/usr/bin/uptime",
                       options: [],
                       resolver: defaultResolver)
            .doCommand()
    }
    
    func measureClock() -> CLResult {
        // vcgencmd measure_clock <clock>
        // clock: arm, core, h264, isp, v3d, uart, pwm, emmc, pixel, vec, hdmi, dpi
        let options = ["arm", "core", "h264", "isp", "v3d", "uart", "pwm", "emmc", "pixel", "vec", "hdmi", "dpi"]
        
        var res = [String: Any]()
        
        for option in options {
            let cmd = Command(cmd: "\(vcgencmd)",
                              options: ["measure_clock", option],
                              resolver: defaultResolver)
            let cmdMapRes = cmd.doCommand().result
            res.merge(zip(cmdMapRes.keys, cmdMapRes.values)) { (current, _) in current }
        }
        
        return CLResult(title: "\(vcgencmd) measure_clock", result: res)
    }
    
    func measureVolts() -> CLResult {
        // vcgencmd measure_volts <id>
        // id: core, sdram_c, sdram_i, sdram_p
        let options = ["core", "sdram_c", "sdram_i", "sdram_p"]
        var res = [String: Any]()
        
        for option in options {
            let cmd = Command(cmd: vcgencmd,
                              options: ["measure_volts", option],
                              resolver: defaultResolver)
            let cmdMapRes = cmd.doCommand().result
            res.merge(zip(cmdMapRes.keys, cmdMapRes.values)) { (current, _) in current }
        }
        
        return CLResult(title: "\(vcgencmd) measure_volts", result: res)
    }
    
    func measureTemp() -> CLResult {
        return Command(cmd: vcgencmd,
                       options: ["measure_temp"],
                       resolver: defaultResolver)
            .doCommand()
    }
    
    func codecEnabled() -> CLResult {
        // vcgencmd codec_enabled <codec>
        // codec: H263, H264, MPG2, WVC1, MPG4, AGIF, MJPA, MJPB, MJPG, WMV9, MVC0
        let options = ["H263", "H264", "MPG2", "WVC1", "MPG4", "AGIF", "MJPA", "MJPB", "MJPG", "WMV9", "MVC0"]
        var res = [String: Any]()
        
        for option in options {
            let cmd = Command(cmd: vcgencmd,
                              options: ["codec_enabled", option],
                              resolver: defaultResolver)
            let cmdMapRes = cmd.doCommand().result
            res.merge(zip(cmdMapRes.keys, cmdMapRes.values)) { (current, _) in current }
        }
        
        return CLResult(title: "\(vcgencmd) codec_enabled", result: res)
    }
    
    func getMem() -> CLResult {
        // vcgencmd get_mem arm/gpu
        let options = ["arm", "gpu"]
        var res = [String: Any]()
        
        for option in options {
            let cmd = Command(cmd: vcgencmd,
                              options: ["get_mem", option],
                              resolver: defaultResolver)
            let cmdMapRes = cmd.doCommand().result
            res.merge(zip(cmdMapRes.keys, cmdMapRes.values)) { (current, _) in current }
        }
        
        return CLResult(title: "\(vcgencmd) get_mem", result: res)
    }
    
    func getLcdInfo() -> CLResult {
        return Command(cmd: vcgencmd,
                       options: ["get_lcd_info"],
                       resolver: defaultResolver)
            .doCommand()
    }
    
}

class DefaultResolver: CLResolver {
    func resolve(cmd: String, option: String, data: Data) -> CLResult {
        let command = "\(cmd) \(option)"
        
        if data.isEmpty {
            return CLResult(title: command, result: [:])
        }
        guard let inputStr = String(data: data, encoding: .utf8) else {
            return CLResult(title: command, result: [:])
        }
        
        let optStr = option.isEmpty
            ? cmd
            : option
        
        return CLResult(title: command, result: [optStr: inputStr])
    }
}
