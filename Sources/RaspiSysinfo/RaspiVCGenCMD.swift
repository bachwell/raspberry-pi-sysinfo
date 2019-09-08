
import Foundation

class RaspiVCGenCMD {
    
    // /opt/vc/bin/vcgencmd  /usr/bin/vcgencmd
    private let vcgencmd: String = "/opt/vc/bin/vcgencmd"

    private let defaultResolver: CLResolver = DefaultResolver()
    
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
        let options = ["arm", "core", "h264", "isp", "v3d", "uart", "pwm", "emmc", "pixel", "vec", "hdmi", "dpi"]
        return CLResult(title: "\(vcgencmd) measure_clock",
            result: optionsIter(option: "measure_clock", options: options))
    }
    
    func measureVolts() -> CLResult {
        let options = ["core", "sdram_c", "sdram_i", "sdram_p"]
        return CLResult(title: "\(vcgencmd) measure_volts",
            result: optionsIter(option: "measure_volts", options: options))
    }
    
    func measureTemp() -> CLResult {
        return Command(cmd: vcgencmd,
                       options: ["measure_temp"],
                       resolver: defaultResolver)
            .doCommand()
    }
    
    func codecEnabled() -> CLResult {
        let options = ["H263", "H264", "MPG2", "WVC1", "MPG4", "AGIF", "MJPA", "MJPB", "MJPG", "WMV9", "MVC0"]
        return CLResult(title: "\(vcgencmd) codec_enabled",
            result: optionsIter(option: "codec_enabled", options: options))
    }
    
    func getMem() -> CLResult {
        let options = ["arm", "gpu"]
        return CLResult(title: "\(vcgencmd) get_mem",
            result: optionsIter(option: "get_mem", options: options))
    }
    
    func getLcdInfo() -> CLResult {
        return Command(cmd: vcgencmd,
                       options: ["get_lcd_info"],
                       resolver: defaultResolver)
            .doCommand()
    }
    
    func getConfig() -> CLResult {
        let options = ["config", "int","str"]
        return CLResult(title: "\(vcgencmd) get_config",
            result: optionsIter(option: "get_config", options: options))
    }
    
    private func optionsIter(option: String, options: [String]) -> [String: Any] {
        var res = [String: Any]()
        
        for optItem in options {
            let cmd = Command(cmd: vcgencmd,
                              options: [option, optItem],
                              resolver: defaultResolver)
            let cmdMapRes = cmd.doCommand().result
            res.merge(zip(cmdMapRes.keys, cmdMapRes.values)) { (current, _) in current }
        }
        
        return res
    }
}
