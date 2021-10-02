//
//  BottomSheetDragIndicator.swift
//  Space
//
//  Created by bran.new on 2021/10/03.
//

import UIKit

final class BottomSheetDragIndicator: UIView {

    private var borderView: UIView = UIView()
    private var dragIndicator: UIView = UIView()

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 28)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateView()
    }

    private func setupView() {
        backgroundColor = .black
        clipsToBounds = true

        addSubview(borderView)
//        borderView.backgroundColor = .systemPink
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = 20
        borderView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        // 보더가 보이지 않도록 constant값으로 벗어나게 설정
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 30)
        ])
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor(red: 0.143, green: 0.156, blue: 0.195, alpha: 1.0).cgColor

        dragIndicator.backgroundColor = UIColor(red: 0.143, green: 0.156, blue: 0.195, alpha: 1.0)
        addSubview(dragIndicator)
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            dragIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dragIndicator.widthAnchor.constraint(equalToConstant: 32),
            dragIndicator.heightAnchor.constraint(equalToConstant: 6)
        ])
        dragIndicator.layer.cornerRadius = 3
    }

    private func updateView() {
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

extension BottomSheetDragIndicator {
    func roundCorners(cornerRadius: CGFloat, byRoundingCorners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: byRoundingCorners,
                                cornerRadii: CGSize(width:cornerRadius, height: cornerRadius))

        let maskLayer = CAShapeLayer()
        maskLayer.borderColor = UIColor.systemPink.cgColor
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath

        layer.addSublayer(maskLayer)
    }
}

fileprivate extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
