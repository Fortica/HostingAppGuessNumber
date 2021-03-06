//
//  SliderValue.swift
//  HostingAppGuessNumber
//
//  Created by Larisa on 17.06.2021.
//

import SwiftUI

struct SliderValue: UIViewRepresentable {
    
    @Binding var value: Double
    
    let alpha: Int
    let color: UIColor
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ view: UISlider, context: Context) {
        view.thumbTintColor = color.withAlphaComponent(CGFloat(alpha) / 100)
        view.value = Float(value)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
}

extension SliderValue {
    class Coordinator: NSObject {
        
        @Binding var value: Double
        
        init(value: Binding<Double>) {
            self._value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        SliderValue(value: .constant(50), alpha: 100, color: .blue)
    }
}

