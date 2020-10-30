//
//  PageTitleView.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit

//MARK:- 定义常量
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
// 滚动下划线的高度
private let scrollLineH = 2.0
//MARK:- pageTitleViewDelegate
protocol pageTitleViewDelegate: class {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex currentIndx: Int)
}

class PageTitleView: UIView {
    //MARK:- 定义属性
    fileprivate let subLineH = 0.5
    fileprivate var titles : [String]
    fileprivate var currIndex = 0
    weak var deleget : pageTitleViewDelegate?
    
    lazy fileprivate var titleLabels: [UILabel] = [UILabel]()
    lazy fileprivate var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        return UIScrollView()
    }()
    lazy fileprivate var scrolLine: UIView = {
        let scrolLine = UIView()
        scrolLine.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1)
        return scrolLine
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- setupUI
fileprivate extension PageTitleView {
    
    
    func setUp(){
        addSubview(scrollView)
        scrollView.frame = bounds
        addLabel()
        addSubline()
        //MARK: 设置
    }
    //MARK: 添加title
    func addLabel() {
        let labeY: CGFloat = 0.0
        let labeW: CGFloat = bounds.width/CGFloat(titles.count)
        let labeH: CGFloat = CGFloat(kTitleViewH)
        //MARK: 创建Label
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16.0)
            label.text = title
            label.isUserInteractionEnabled = true
            label.tag = index
            label.textAlignment = .center
            label.frame = CGRect(x: CGFloat(index) * labeW, y: labeY, width: labeW, height: labeH)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
            label.addGestureRecognizer(tap)
        }
    }
    func addSubline() {
        let lineFrame = CGRect(x: 0, y: kTitleViewH - subLineH, width: Double(kScreenW), height: subLineH)
        let lineView = UIView(frame: lineFrame)
        lineView.backgroundColor = .lightGray
        addSubview(lineView)
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1)
        
        let scrollFrame = CGRect(x: Double(CGFloat(currIndex) * firstLabel.frame.width)  , y: kTitleViewH - scrollLineH, width: Double(firstLabel.frame.width) , height: scrollLineH)
        scrolLine.frame = scrollFrame
        scrollView.addSubview(scrolLine)
    }
    
   
}

//MARK:- 业务
fileprivate extension PageTitleView{
    @objc func tapLabel(_ tapGes: UITapGestureRecognizer) {
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        if currentLabel.tag == currIndex { return }
        let oldLabel = titleLabels[currIndex]
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1.0)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1)
        
        currIndex = currentLabel.tag
        let scrollLineX = scrolLine.frame.width * CGFloat(currIndex)
        UIView.animate(withDuration: 0.15) {
            self.scrolLine.frame.origin.x = scrollLineX
        }
        deleget?.pageTitleView(self, selectedIndex: currIndex)
    }
}
//MARK:- 外接接口
extension PageTitleView{
    func setCurrentIndex(sourIndex oldIndex: Int, targeIndex willIndex: Int, progress ration: CGFloat)  {
        let oldLabel = titleLabels[oldIndex]
        let willLabel = titleLabels[willIndex]
        let rangColor = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //TODO:- 定义运算符
        oldLabel.textColor = UIColor(r: kSelectColor.0 - rangColor.0 * ration, g: kSelectColor.1 - rangColor.1 * ration, b: kSelectColor.2 - rangColor.2 * ration, a: 1)
        willLabel.textColor = UIColor(r: kNormalColor.0 + rangColor.0 * ration, g: kNormalColor.1 + rangColor.1 * ration, b: kNormalColor.2 + rangColor.2 * ration, a: 1)
        //移动滑块
        let moveTotalX = willLabel.frame.origin.x - oldLabel.frame.origin.x
        let moveX = moveTotalX * ration
        scrolLine.frame.origin.x = oldLabel.frame.origin.x + moveX
        
        currIndex = willIndex
    }
}
