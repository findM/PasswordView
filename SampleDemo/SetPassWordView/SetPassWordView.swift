//
//  SetPassWordView.swift
//  SampleDemo
//
//  Created by 陈光临 on 15/11/30.
//  Copyright © 2015年 cn.chenguanglin. All rights reserved.
//

import UIKit

// MARK: - UIView的扩展
extension UIView{
    func removeAllSubviews(){
        for view:UIView in self.subviews{
            view.removeFromSuperview()
        }
    }
    
    func removeSubViewWithTag(tag:Int){
        for view:UIView in self.subviews{
            if(view.tag == tag){
                view.removeFromSuperview()
            }
        }
    }
}


/// 输密码完成的回调
typealias doneActionBlock = (String) -> ()


internal class SetPassWordView: UIView ,UITextFieldDelegate{
//MARK: public
    /// 密码数量
    var count = 6
    /// 线条颜色
    var lineColor: UIColor = UIColor.grayColor()
    /// 点的颜色
    var dotColor: UIColor = UIColor.grayColor()
    /// 点的大小
    var dotRadius: CGFloat = 10
    /// 完成输入的回调
    var doneAction: doneActionBlock?

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = lineColor.CGColor
        
        inputeTextField.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        renderLine(self)
    }

//MARK: private
    /// 点的tag 用与移除点，从新渲染
    private let dotTag = 1
    
    private lazy var inputeTextField: UITextField = {
        let inputeTextField = UITextField()
        inputeTextField.keyboardType = .NumberPad
        inputeTextField.delegate = self
        inputeTextField.hidden = true
        return inputeTextField
    }()
    /**
     渲染中间线的方法
     */
    private func renderLine(bgView:UIView){
        let w:CGFloat = self.bounds.size.width / CGFloat(count)
        let h:CGFloat = self.bounds.size.height
        var x: CGFloat = 0
        for index in 1...count - 1{
            x = CGFloat(index) * w
            let line = UIImageView()
            line.frame = CGRect(x: x, y: 0.0, width: 0.5, height: h)
            line.backgroundColor = lineColor
            bgView.addSubview(line)
        }
    }
    
    /**
     渲染点的方法
     */
    private func renderDot(fieldView:UITextField,bgView:UIView){
        let w:CGFloat = self.bounds.size.width / CGFloat(self.count)
        let h:CGFloat = self.bounds.size.height
        
        var x:CGFloat = (w - dotRadius) / 2
        let y:CGFloat = (h - dotRadius) / 2
        
        let count = fieldView.text?.characters.count < 7 ? fieldView.text?.characters.count: 6
        
        for var index = 0; index < count; ++index {
            let dot = UIView()
            dot.tag = dotTag
            dot.backgroundColor = dotColor
            dot.frame = CGRect(x: x, y: y, width: dotRadius, height: dotRadius)
            x = x + w
            dot.layer.cornerRadius = dot.bounds.size.width / 2
            dot.clipsToBounds = true
            bgView.addSubview(dot)
        }
    }
    /**
     监听inputeTextField的改变
     */
    func fieldViewDidChange(){
        
        self.removeSubViewWithTag(dotTag)
        
        renderDot(inputeTextField, bgView: self)
        
        if(inputeTextField.text?.characters.count == count && self.doneAction != nil){
            self.doneAction!(inputeTextField.text!)
        }
        
    }
    /**
     点击view弹出键盘
     */
    func tapAction(){
        self.inputeTextField.becomeFirstResponder()
    }
    
//MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSubViews()
    }
    
    private func setUpSubViews(){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = lineColor.CGColor
        
        
        let tap = UITapGestureRecognizer(target: self, action: "tapAction")
        self.addGestureRecognizer(tap)
        
        self.addSubview(inputeTextField)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fieldViewDidChange", name: UITextFieldTextDidChangeNotification, object: inputeTextField)
    }
    
//MARK: UITextFieldDelegate
    /**
    限制输入的内容不超过密码的个数
    */
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let str = textField.text! + string
        
        if(str.characters.count > count){
            return false
        }else{
            return true
        }
    }
    
}
