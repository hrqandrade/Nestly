import UIKit

public enum NestlyColor {
    public static let brandPrimary = UIColor(hex: 0x344132)
    public static let brandPrimaryPressed = UIColor(hex: 0x273126)
    public static let brandPrimarySoft = UIColor(hex: 0xE8EDE5)
    public static let accent = UIColor(hex: 0xB08A52)
    public static let background = UIColor(hex: 0xF6F4EF)
    public static let surface = UIColor(hex: 0xFFFFFF)
    public static let textPrimary = UIColor(hex: 0x1D1E1A)
    public static let textSecondary = UIColor(hex: 0x66685F)
    public static let border = UIColor(hex: 0xDEDBD2)
    public static let success = UIColor(hex: 0x3E7A57)
    public static let warning = UIColor(hex: 0xA96A2D)
    public static let danger = UIColor(hex: 0xB24C52)
    public static let favorite = UIColor(hex: 0xC45466)
}

private extension UIColor {
    convenience init(hex: UInt32) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}

