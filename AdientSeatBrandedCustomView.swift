//
//  AdientSeatBrandedCustomView.swift
//
//  Code generated using QuartzCode 1.55.0 on 1/19/17.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class AdientSeatBrandedCustomView: UIView, CAAnimationDelegate {
	
	var updateLayerValueForCompletedAnimation : Bool = true
	var animationAdded : Bool = false
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var layers : Dictionary<String, AnyObject> = [:]
	
	
	
	//MARK: - Life Cycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayers()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupProperties()
		setupLayers()
	}
	
	var adientBrandingAnimProgress: CGFloat = 0{
		didSet{
			if(!self.animationAdded){
				removeAllAnimations()
				addAdientBrandingAnimation()
				self.animationAdded = true
				layer.speed = 0
				layer.timeOffset = 0
			}
			else{
				let totalDuration : CGFloat = 4.71
				let offset = adientBrandingAnimProgress * totalDuration
				layer.timeOffset = CFTimeInterval(offset)
			}
		}
	}
	
	override var frame: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	override var bounds: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	func setupProperties(){
		
	}
	
	func setupLayers(){
		self.backgroundColor = UIColor(red:0.0191, green: 0.195, blue:0.248, alpha:1)
		
		let SplashAdient = CALayer()
		self.layer.addSublayer(SplashAdient)
		layers["SplashAdient"] = SplashAdient
		let ADient = CALayer()
		SplashAdient.addSublayer(ADient)
		layers["ADient"] = ADient
		let A = CAShapeLayer()
		ADient.addSublayer(A)
		layers["A"] = A
		let D = CAShapeLayer()
		ADient.addSublayer(D)
		layers["D"] = D
		let I = CAShapeLayer()
		ADient.addSublayer(I)
		layers["I"] = I
		let E = CAShapeLayer()
		ADient.addSublayer(E)
		layers["E"] = E
		let N = CAShapeLayer()
		ADient.addSublayer(N)
		layers["N"] = N
		let T = CAShapeLayer()
		ADient.addSublayer(T)
		layers["T"] = T
		
		let chair = CALayer()
		self.layer.addSublayer(chair)
		layers["chair"] = chair
		
		let chair3justseat = CALayer()
		self.layer.addSublayer(chair3justseat)
		layers["chair3justseat"] = chair3justseat
		
		let AisForAdientReversed = CALayer()
		self.layer.addSublayer(AisForAdientReversed)
		layers["AisForAdientReversed"] = AisForAdientReversed
		
		let AdientSlantReversed = CALayer()
		self.layer.addSublayer(AdientSlantReversed)
		layers["AdientSlantReversed"] = AdientSlantReversed
		
		let AdientSlantReversed2 = CALayer()
		self.layer.addSublayer(AdientSlantReversed2)
		layers["AdientSlantReversed2"] = AdientSlantReversed2
		
		let crane_arm = CALayer()
		self.layer.addSublayer(crane_arm)
		layers["crane_arm"] = crane_arm
		
		let seatback = CALayer()
		self.layer.addSublayer(seatback)
		layers["seatback"] = seatback
		
		resetLayerProperties(forLayerIdentifiers: nil)
		setupLayerFrames()
	}
	
	func resetLayerProperties(forLayerIdentifiers layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("SplashAdient"){
			let SplashAdient = layers["SplashAdient"] as! CALayer
			SplashAdient.backgroundColor = UIColor(red:0.0191, green: 0.195, blue:0.248, alpha:1).cgColor
		}
		if layerIds == nil || layerIds.contains("A"){
			let A = layers["A"] as! CAShapeLayer
			A.opacity     = 0.06
			A.lineJoin    = kCALineJoinRound
			A.fillColor   = UIColor.white.cgColor
			A.strokeColor = UIColor.black.cgColor
			A.lineWidth   = 0
		}
		if layerIds == nil || layerIds.contains("D"){
			let D = layers["D"] as! CAShapeLayer
			D.opacity     = 0.06
			D.lineJoin    = kCALineJoinRound
			D.fillColor   = UIColor.white.cgColor
			D.strokeColor = UIColor.black.cgColor
			D.lineWidth   = 0
		}
		if layerIds == nil || layerIds.contains("I"){
			let I = layers["I"] as! CAShapeLayer
			I.opacity     = 0.06
			I.lineJoin    = kCALineJoinRound
			I.fillColor   = UIColor.white.cgColor
			I.strokeColor = UIColor.black.cgColor
			I.lineWidth   = 0
		}
		if layerIds == nil || layerIds.contains("E"){
			let E = layers["E"] as! CAShapeLayer
			E.opacity     = 0.06
			E.lineJoin    = kCALineJoinRound
			E.fillColor   = UIColor.white.cgColor
			E.strokeColor = UIColor.black.cgColor
			E.lineWidth   = 0
		}
		if layerIds == nil || layerIds.contains("N"){
			let N = layers["N"] as! CAShapeLayer
			N.opacity     = 0.06
			N.lineJoin    = kCALineJoinRound
			N.fillColor   = UIColor.white.cgColor
			N.strokeColor = UIColor.black.cgColor
			N.lineWidth   = 0
		}
		if layerIds == nil || layerIds.contains("T"){
			let T = layers["T"] as! CAShapeLayer
			T.opacity     = 0.06
			T.lineJoin    = kCALineJoinRound
			T.fillColor   = UIColor.white.cgColor
			T.strokeColor = UIColor.black.cgColor
			T.lineWidth   = 0
		}
		if layerIds == nil || layerIds.contains("chair"){
			let chair = layers["chair"] as! CALayer
			chair.contents        = UIImage(named:"chair-3")?.cgImage
			chair.contentsGravity = kCAGravityResizeAspect
		}
		if layerIds == nil || layerIds.contains("chair3justseat"){
			let chair3justseat = layers["chair3justseat"] as! CALayer
			chair3justseat.contents = UIImage(named:"chair-3-just-seat")?.cgImage
		}
		if layerIds == nil || layerIds.contains("AisForAdientReversed"){
			let AisForAdientReversed = layers["AisForAdientReversed"] as! CALayer
			AisForAdientReversed.contents = UIImage(named:"AisForAdientReversed")?.cgImage
		}
		if layerIds == nil || layerIds.contains("AdientSlantReversed"){
			let AdientSlantReversed = layers["AdientSlantReversed"] as! CALayer
			AdientSlantReversed.contents = UIImage(named:"AdientSlantReversed")?.cgImage
		}
		if layerIds == nil || layerIds.contains("AdientSlantReversed2"){
			let AdientSlantReversed2 = layers["AdientSlantReversed2"] as! CALayer
			AdientSlantReversed2.contents = UIImage(named:"AdientSlantReversed")?.cgImage
		}
		if layerIds == nil || layerIds.contains("crane_arm"){
			let crane_arm = layers["crane_arm"] as! CALayer
			crane_arm.contents = UIImage(named:"crane_arm")?.cgImage
		}
		if layerIds == nil || layerIds.contains("seatback"){
			let seatback = layers["seatback"] as! CALayer
			seatback.contents = UIImage(named:"seat-back")?.cgImage
		}
		
		CATransaction.commit()
	}
	
	func setupLayerFrames(){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if let SplashAdient : CALayer = layers["SplashAdient"] as? CALayer{
			SplashAdient.frame = CGRect(x: 0, y: 0.94328 * SplashAdient.superlayer!.bounds.height, width: 0.13298 * SplashAdient.superlayer!.bounds.width, height: 0.08657 * SplashAdient.superlayer!.bounds.height)
		}
		
		if let ADient : CALayer = layers["ADient"] as? CALayer{
			ADient.frame = CGRect(x: 2.5725 * ADient.superlayer!.bounds.width, y: -13.23116 * ADient.superlayer!.bounds.height, width: 4.20469 * ADient.superlayer!.bounds.width, height: 0.58384 * ADient.superlayer!.bounds.height)
		}
		
		if let A : CAShapeLayer = layers["A"] as? CAShapeLayer{
			A.frame = CGRect(x: -0.23185 * A.superlayer!.bounds.width, y: 3.06716 * A.superlayer!.bounds.height, width: 0.17354 * A.superlayer!.bounds.width, height: 1 * A.superlayer!.bounds.height)
			A.path  = APath(bounds: (layers["A"] as! CAShapeLayer).bounds).cgPath
		}
		
		if let D : CAShapeLayer = layers["D"] as? CAShapeLayer{
			D.frame = CGRect(x: 0.00591 * D.superlayer!.bounds.width, y: 3.08193 * D.superlayer!.bounds.height, width: 0.1356 * D.superlayer!.bounds.width, height:  D.superlayer!.bounds.height)
			D.path  = DPath(bounds: (layers["D"] as! CAShapeLayer).bounds).cgPath
		}
		
		if let I : CAShapeLayer = layers["I"] as? CAShapeLayer{
			I.frame = CGRect(x: 0.17715 * I.superlayer!.bounds.width, y: 3.08193 * I.superlayer!.bounds.height, width: 0.04084 * I.superlayer!.bounds.width, height:  I.superlayer!.bounds.height)
			I.path  = IPath(bounds: (layers["I"] as! CAShapeLayer).bounds).cgPath
		}
		
		if let E : CAShapeLayer = layers["E"] as? CAShapeLayer{
			E.frame = CGRect(x: 0.27232 * E.superlayer!.bounds.width, y: 3.08193 * E.superlayer!.bounds.height, width: 0.14225 * E.superlayer!.bounds.width, height:  E.superlayer!.bounds.height)
			E.path  = EPath(bounds: (layers["E"] as! CAShapeLayer).bounds).cgPath
		}
		
		if let N : CAShapeLayer = layers["N"] as? CAShapeLayer{
			N.frame = CGRect(x: 0.4602 * N.superlayer!.bounds.width, y: 3.08193 * N.superlayer!.bounds.height, width: 0.15935 * N.superlayer!.bounds.width, height:  N.superlayer!.bounds.height)
			N.path  = NPath(bounds: (layers["N"] as! CAShapeLayer).bounds).cgPath
		}
		
		if let T : CAShapeLayer = layers["T"] as? CAShapeLayer{
			T.frame = CGRect(x: 0.65756 * T.superlayer!.bounds.width, y: 3.08193 * T.superlayer!.bounds.height, width: 0.15935 * T.superlayer!.bounds.width, height:  T.superlayer!.bounds.height)
			T.path  = TPath(bounds: (layers["T"] as! CAShapeLayer).bounds).cgPath
		}
		
		if let chair : CALayer = layers["chair"] as? CALayer{
			chair.frame = CGRect(x: 0.80452 * chair.superlayer!.bounds.width, y: 0.07313 * chair.superlayer!.bounds.height, width: 0.85106 * chair.superlayer!.bounds.width, height: 0.32836 * chair.superlayer!.bounds.height)
		}
		
		if let chair3justseat : CALayer = layers["chair3justseat"] as? CALayer{
			chair3justseat.frame = CGRect(x: -0.52926 * chair3justseat.superlayer!.bounds.width, y: 0.23955 * chair3justseat.superlayer!.bounds.height, width: 0.85106 * chair3justseat.superlayer!.bounds.width, height: 0.35821 * chair3justseat.superlayer!.bounds.height)
		}
		
		if let AisForAdientReversed : CALayer = layers["AisForAdientReversed"] as? CALayer{
			AisForAdientReversed.frame = CGRect(x: 0.19016 * AisForAdientReversed.superlayer!.bounds.width, y: 0.47015 * AisForAdientReversed.superlayer!.bounds.height, width: 0.12766 * AisForAdientReversed.superlayer!.bounds.width, height: 0.06343 * AisForAdientReversed.superlayer!.bounds.height)
		}
		
		if let AdientSlantReversed : CALayer = layers["AdientSlantReversed"] as? CALayer{
			AdientSlantReversed.frame = CGRect(x: 1.03457 * AdientSlantReversed.superlayer!.bounds.width, y: 0.08284 * AdientSlantReversed.superlayer!.bounds.height, width: 0.10106 * AdientSlantReversed.superlayer!.bounds.width, height: 0.05299 * AdientSlantReversed.superlayer!.bounds.height)
		}
		
		if let AdientSlantReversed2 : CALayer = layers["AdientSlantReversed2"] as? CALayer{
			AdientSlantReversed2.frame = CGRect(x: 1.20479 * AdientSlantReversed2.superlayer!.bounds.width, y: 0.00563 * AdientSlantReversed2.superlayer!.bounds.height, width: 0.10106 * AdientSlantReversed2.superlayer!.bounds.width, height: 0.05299 * AdientSlantReversed2.superlayer!.bounds.height)
		}
		
		if let crane_arm : CALayer = layers["crane_arm"] as? CALayer{
			crane_arm.frame = CGRect(x: 1.19149 * crane_arm.superlayer!.bounds.width, y: 0.02276 * crane_arm.superlayer!.bounds.height, width: 0.34309 * crane_arm.superlayer!.bounds.width, height: 0.10075 * crane_arm.superlayer!.bounds.height)
		}
		
		if let seatback : CALayer = layers["seatback"] as? CALayer{
			seatback.frame = CGRect(x: 0.16576 * seatback.superlayer!.bounds.width, y: 0.29783 * seatback.superlayer!.bounds.height, width: 0.21011 * seatback.superlayer!.bounds.width, height: 0.25746 * seatback.superlayer!.bounds.height)
		}
		
		CATransaction.commit()
	}
	
	//MARK: - Animation Setup
	
	func addAdientBrandingAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil){
		if completionBlock != nil{
			let completionAnim = CABasicAnimation(keyPath:"completionAnim")
			completionAnim.duration = 4.711
			completionAnim.delegate = self
			completionAnim.setValue("AdientBranding", forKey:"animId")
			completionAnim.setValue(false, forKey:"needEndAnim")
			layer.add(completionAnim, forKey:"AdientBranding")
			if let anim = layer.animation(forKey: "AdientBranding"){
				completionBlocks[anim] = completionBlock
			}
		}
		
		self.layer.speed = 1
		self.animationAdded = false
		
		let fillMode : String = kCAFillModeForwards
		
		let A = layers["A"] as! CAShapeLayer
		
		////A animation
		let ATransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		ATransformAnim.values         = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.97, 1, 1), CATransform3DMakeTranslation(0, 11.443 * A.superlayer!.bounds.height, 1))), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 10.336 * A.superlayer!.bounds.height, 0))]
		ATransformAnim.keyTimes       = [0, 0.682, 1]
		ATransformAnim.duration       = 0.986
		ATransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
		
		let AOpacityAnim            = CAKeyframeAnimation(keyPath:"opacity")
		AOpacityAnim.values         = [0.05, 1, 1, 1, 0]
		AOpacityAnim.keyTimes       = [0, 0.203, 0.206, 0.858, 1]
		AOpacityAnim.duration       = 3.22
		AOpacityAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		
		let AAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [ATransformAnim, AOpacityAnim], fillMode:fillMode)
		A.add(AAdientBrandingAnim, forKey:"AAdientBrandingAnim")
		
		let D = layers["D"] as! CAShapeLayer
		
		////D animation
		let DTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		DTransformAnim.values         = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 11.443 * D.superlayer!.bounds.height, 0)), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 10.336 * D.superlayer!.bounds.height, 0))]
		DTransformAnim.keyTimes       = [0, 0.663, 1]
		DTransformAnim.duration       = 1.13
		DTransformAnim.beginTime      = 0.152
		DTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
		
		let DOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
		DOpacityAnim.values    = [0.055, 1]
		DOpacityAnim.keyTimes  = [0, 1]
		DOpacityAnim.duration  = 1.13
		DOpacityAnim.beginTime = 0.152
		
		let DAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [DTransformAnim, DOpacityAnim], fillMode:fillMode)
		D.add(DAdientBrandingAnim, forKey:"DAdientBrandingAnim")
		
		let I = layers["I"] as! CAShapeLayer
		
		////I animation
		let ITransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		ITransformAnim.values         = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(1, 1, 0.97), CATransform3DMakeTranslation(0, 11.369 * I.superlayer!.bounds.height, 0))), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 10.336 * I.superlayer!.bounds.height, 0))]
		ITransformAnim.keyTimes       = [0, 0.684, 1]
		ITransformAnim.duration       = 1.09
		ITransformAnim.beginTime      = 0.4
		ITransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
		
		let IOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
		IOpacityAnim.values    = [0.055, 1]
		IOpacityAnim.keyTimes  = [0, 1]
		IOpacityAnim.duration  = 1.09
		IOpacityAnim.beginTime = 0.4
		
		let IAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [ITransformAnim, IOpacityAnim], fillMode:fillMode)
		I.add(IAdientBrandingAnim, forKey:"IAdientBrandingAnim")
		
		let E = layers["E"] as! CAShapeLayer
		
		////E animation
		let ETransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		ETransformAnim.values         = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 11.443 * E.superlayer!.bounds.height, 0)), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 10.336 * E.superlayer!.bounds.height, 0))]
		ETransformAnim.keyTimes       = [0, 0.604, 1]
		ETransformAnim.duration       = 1
		ETransformAnim.beginTime      = 0.673
		ETransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
		
		let EOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
		EOpacityAnim.values    = [0.055, 1]
		EOpacityAnim.keyTimes  = [0, 1]
		EOpacityAnim.duration  = 1
		EOpacityAnim.beginTime = 0.671
		
		let EAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [ETransformAnim, EOpacityAnim], fillMode:fillMode)
		E.add(EAdientBrandingAnim, forKey:"EAdientBrandingAnim")
		
		let N = layers["N"] as! CAShapeLayer
		
		////N animation
		let NTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		NTransformAnim.values         = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 11.443 * N.superlayer!.bounds.height, 0)), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 10.336 * N.superlayer!.bounds.height, 0))]
		NTransformAnim.keyTimes       = [0, 0.693, 1]
		NTransformAnim.duration       = 0.909
		NTransformAnim.beginTime      = 0.898
		NTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
		
		let NOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
		NOpacityAnim.values    = [0.055, 1]
		NOpacityAnim.keyTimes  = [0, 1]
		NOpacityAnim.duration  = 0.909
		NOpacityAnim.beginTime = 0.898
		
		let NAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [NTransformAnim, NOpacityAnim], fillMode:fillMode)
		N.add(NAdientBrandingAnim, forKey:"NAdientBrandingAnim")
		
		let T = layers["T"] as! CAShapeLayer
		
		////T animation
		let TTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		TTransformAnim.values         = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 11.443 * T.superlayer!.bounds.height, -3)), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(0, 10.336 * T.superlayer!.bounds.height, 0))]
		TTransformAnim.keyTimes       = [0, 0.7, 1]
		TTransformAnim.duration       = 0.943
		TTransformAnim.beginTime      = 1.09
		TTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
		
		let TOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
		TOpacityAnim.values    = [0.055, 1]
		TOpacityAnim.keyTimes  = [0, 1]
		TOpacityAnim.duration  = 0.943
		TOpacityAnim.beginTime = 1.09
		
		let TAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [TTransformAnim, TOpacityAnim], fillMode:fillMode)
		T.add(TAdientBrandingAnim, forKey:"TAdientBrandingAnim")
		
		let chair = layers["chair"] as! CALayer
		
		////Chair animation
		let chairTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		chairTransformAnim.values   = [NSValue(caTransform3D: CATransform3DMakeRotation(25 * CGFloat(M_PI/180), 0, 0, -1)), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.8, 0.8, 1), CATransform3DMakeTranslation(-1.0638 * chair.superlayer!.bounds.width, 0, 0))), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(-0.99734 * chair.superlayer!.bounds.width, 0.23134 * chair.superlayer!.bounds.height, 0)), CATransform3DMakeRotation(25 * CGFloat(M_PI/180), -30, -12.4, 1))), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(-0.99734 * chair.superlayer!.bounds.width, 0.22388 * chair.superlayer!.bounds.height, 0))), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(-0.99734 * chair.superlayer!.bounds.width, 0.22388 * chair.superlayer!.bounds.height, 0)))]
		chairTransformAnim.keyTimes = [0, 0.404, 0.666, 0.787, 1]
		chairTransformAnim.duration = 2.47
		
		let chairOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
		chairOpacityAnim.values    = [0.5, 1, 1, 0]
		chairOpacityAnim.keyTimes  = [0, 0.363, 0.79, 1]
		chairOpacityAnim.duration  = 3.74
		chairOpacityAnim.beginTime = 0.0606
		
		let chairBackgroundColorAnim       = CAKeyframeAnimation(keyPath:"backgroundColor")
		chairBackgroundColorAnim.values    = []
		chairBackgroundColorAnim.keyTimes  = [0, 1]
		chairBackgroundColorAnim.duration  = 1
		chairBackgroundColorAnim.beginTime = 1.65
		
		let chairPositionAnim       = CAKeyframeAnimation(keyPath:"position")
		chairPositionAnim.values    = [NSValue(cgPoint: CGPoint(x: 1.23005 * chair.superlayer!.bounds.width, y: 0.23731 * chair.superlayer!.bounds.height)), NSValue(cgPoint: CGPoint(x: -0.13298 * chair.superlayer!.bounds.width, y: 0.14925 * chair.superlayer!.bounds.height))]
		chairPositionAnim.keyTimes  = [0, 1]
		chairPositionAnim.duration  = 1
		chairPositionAnim.beginTime = 3.5
		
		let chairHiddenAnim      = CAKeyframeAnimation(keyPath:"hidden")
		chairHiddenAnim.values   = [false, false, true, true]
		chairHiddenAnim.keyTimes = [0, 0.852, 0.948, 1]
		chairHiddenAnim.duration = 3.33
		
		let chairAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [chairTransformAnim, chairOpacityAnim, chairBackgroundColorAnim, chairPositionAnim, chairHiddenAnim], fillMode:fillMode)
		chair.add(chairAdientBrandingAnim, forKey:"chairAdientBrandingAnim")
		
		let chair3justseat = layers["chair3justseat"] as! CALayer
		
		////Chair3justseat animation
		let chair3justseatTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
		chair3justseatTransformAnim.values    = [NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(0.31649 * chair3justseat.superlayer!.bounds.width, 0.044776 * chair3justseat.superlayer!.bounds.height, 0))), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(0.31649 * chair3justseat.superlayer!.bounds.width, 0.044776 * chair3justseat.superlayer!.bounds.height, 0))), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(0.066489 * chair3justseat.superlayer!.bounds.width, 0.044776 * chair3justseat.superlayer!.bounds.height, 0)))]
		chair3justseatTransformAnim.keyTimes  = [0, 0.146, 1]
		chair3justseatTransformAnim.duration  = 2.12
		chair3justseatTransformAnim.beginTime = 2.53
		
		let chair3justseatOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
		chair3justseatOpacityAnim.values   = [0, 0, 1, 0]
		chair3justseatOpacityAnim.keyTimes = [0, 0.671, 0.713, 1]
		chair3justseatOpacityAnim.duration = 4.23
		
		let chair3justseatAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [chair3justseatTransformAnim, chair3justseatOpacityAnim], fillMode:fillMode)
		chair3justseat.add(chair3justseatAdientBrandingAnim, forKey:"chair3justseatAdientBrandingAnim")
		
		let AisForAdientReversed = layers["AisForAdientReversed"] as! CALayer
		
		////AisForAdientReversed animation
		let AisForAdientReversedTransformAnim = CAKeyframeAnimation(keyPath:"transform")
		AisForAdientReversedTransformAnim.values = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DIdentity)]
		AisForAdientReversedTransformAnim.keyTimes = [0, 1]
		AisForAdientReversedTransformAnim.duration = 1.49
		AisForAdientReversedTransformAnim.beginTime = 3.16
		AisForAdientReversedTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
		
		let AisForAdientReversedOpacityAnim    = CAKeyframeAnimation(keyPath:"opacity")
		AisForAdientReversedOpacityAnim.values = [0, 0, 1, 1]
		AisForAdientReversedOpacityAnim.keyTimes = [0, 0.596, 0.633, 1]
		AisForAdientReversedOpacityAnim.duration = 4.64
		
		let AisForAdientReversedHiddenAnim    = CAKeyframeAnimation(keyPath:"hidden")
		AisForAdientReversedHiddenAnim.values = [true, true, false, false]
		AisForAdientReversedHiddenAnim.keyTimes = [0, 0.655, 0.689, 1]
		AisForAdientReversedHiddenAnim.duration = 4.04
		
		let AisForAdientReversedAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [AisForAdientReversedTransformAnim, AisForAdientReversedOpacityAnim, AisForAdientReversedHiddenAnim], fillMode:fillMode)
		AisForAdientReversed.add(AisForAdientReversedAdientBrandingAnim, forKey:"AisForAdientReversedAdientBrandingAnim")
		
		let AdientSlantReversed = layers["AdientSlantReversed"] as! CALayer
		
		////AdientSlantReversed animation
		let AdientSlantReversedTransformAnim = CAKeyframeAnimation(keyPath:"transform")
		AdientSlantReversedTransformAnim.values = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(-0.97739 * AdientSlantReversed.superlayer!.bounds.width, 0.47015 * AdientSlantReversed.superlayer!.bounds.height, 0)), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(-0.94415 * AdientSlantReversed.superlayer!.bounds.width, 0.45 * AdientSlantReversed.superlayer!.bounds.height, 0))]
		AdientSlantReversedTransformAnim.keyTimes = [0, 0.865, 1]
		AdientSlantReversedTransformAnim.duration = 1.58
		AdientSlantReversedTransformAnim.beginTime = 1.64
		
		let AdientSlantReversedHiddenAnim      = CAKeyframeAnimation(keyPath:"hidden")
		AdientSlantReversedHiddenAnim.values   = [true, false, false]
		AdientSlantReversedHiddenAnim.keyTimes = [0, 0.347, 1]
		AdientSlantReversedHiddenAnim.duration = 4.7
		
		let AdientSlantReversedAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [AdientSlantReversedTransformAnim, AdientSlantReversedHiddenAnim], fillMode:fillMode)
		AdientSlantReversed.add(AdientSlantReversedAdientBrandingAnim, forKey:"AdientSlantReversedAdientBrandingAnim")
		
		let AdientSlantReversed2 = layers["AdientSlantReversed2"] as! CALayer
		
		////AdientSlantReversed2 animation
		let AdientSlantReversed2TransformAnim = CAKeyframeAnimation(keyPath:"transform")
		AdientSlantReversed2TransformAnim.values = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(-0.97074 * AdientSlantReversed2.superlayer!.bounds.width, 0.44925 * AdientSlantReversed2.superlayer!.bounds.height, 0)), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(-0.89229 * AdientSlantReversed2.superlayer!.bounds.width, 0.40299 * AdientSlantReversed2.superlayer!.bounds.height, 0))]
		AdientSlantReversed2TransformAnim.keyTimes = [0, 0.865, 1]
		AdientSlantReversed2TransformAnim.duration = 1.68
		AdientSlantReversed2TransformAnim.beginTime = 1.65
		AdientSlantReversed2TransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
		
		let AdientSlantReversed2HiddenAnim    = CAKeyframeAnimation(keyPath:"hidden")
		AdientSlantReversed2HiddenAnim.values = [true, false, false, false]
		AdientSlantReversed2HiddenAnim.keyTimes = [0, 0.315, 0.35, 1]
		AdientSlantReversed2HiddenAnim.duration = 4.7
		
		let AdientSlantReversed2AdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [AdientSlantReversed2TransformAnim, AdientSlantReversed2HiddenAnim], fillMode:fillMode)
		AdientSlantReversed2.add(AdientSlantReversed2AdientBrandingAnim, forKey:"AdientSlantReversed2AdientBrandingAnim")
		
		let crane_arm = layers["crane_arm"] as! CALayer
		
		////Crane_arm animation
		let crane_armTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		crane_armTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeTranslation(-1.5957 * crane_arm.superlayer!.bounds.width, 0, 0))]
		crane_armTransformAnim.keyTimes = [0, 1]
		crane_armTransformAnim.duration = 1.52
		
		let crane_armAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [crane_armTransformAnim], fillMode:fillMode)
		crane_arm.add(crane_armAdientBrandingAnim, forKey:"crane_armAdientBrandingAnim")
		
		let seatback = layers["seatback"] as! CALayer
		
		////Seatback animation
		let seatbackTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		seatbackTransformAnim.values         = [NSValue(caTransform3D: CATransform3DMakeScale(0.75, 0.75, 1)), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(0.066489 * seatback.superlayer!.bounds.width, 0, 0))), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(0.066489 * seatback.superlayer!.bounds.width, 0, 0)), CATransform3DMakeRotation(90 * CGFloat(M_PI/180), 0, -0, 1))), 
			 NSValue(caTransform3D: CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(0.75, 0.75, 1), CATransform3DMakeTranslation(0.66489 * seatback.superlayer!.bounds.width, -0.22388 * seatback.superlayer!.bounds.height, 0)), CATransform3DMakeRotation(180 * CGFloat(M_PI/180), 0, -0, 1)))]
		seatbackTransformAnim.keyTimes       = [0, 0.171, 0.282, 1]
		seatbackTransformAnim.duration       = 1.81
		seatbackTransformAnim.beginTime      = 2.53
		seatbackTransformAnim.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
		
		let seatbackOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
		seatbackOpacityAnim.values   = [0, 0, 1]
		seatbackOpacityAnim.keyTimes = [0, 0.891, 1]
		seatbackOpacityAnim.duration = 2.84
		
		let seatbackHiddenAnim      = CAKeyframeAnimation(keyPath:"hidden")
		seatbackHiddenAnim.values   = [true, true, true, false]
		seatbackHiddenAnim.keyTimes = [0, 0.832, 0.911, 1]
		seatbackHiddenAnim.duration = 3.04
		
		let seatbackAdientBrandingAnim : CAAnimationGroup = QCMethod.group(animations: [seatbackTransformAnim, seatbackOpacityAnim, seatbackHiddenAnim], fillMode:fillMode)
		seatback.add(seatbackAdientBrandingAnim, forKey:"seatbackAdientBrandingAnim")
	}
	
	//MARK: - Animation Cleanup
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
		if let completionBlock = completionBlocks[anim]{
			completionBlocks.removeValue(forKey: anim)
			if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
				updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
				removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
			}
			completionBlock(flag)
		}
	}
	
	func updateLayerValues(forAnimationId identifier: String){
		if identifier == "AdientBranding"{
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["A"] as! CALayer).animation(forKey: "AAdientBrandingAnim"), theLayer:(layers["A"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["D"] as! CALayer).animation(forKey: "DAdientBrandingAnim"), theLayer:(layers["D"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["I"] as! CALayer).animation(forKey: "IAdientBrandingAnim"), theLayer:(layers["I"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["E"] as! CALayer).animation(forKey: "EAdientBrandingAnim"), theLayer:(layers["E"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["N"] as! CALayer).animation(forKey: "NAdientBrandingAnim"), theLayer:(layers["N"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["T"] as! CALayer).animation(forKey: "TAdientBrandingAnim"), theLayer:(layers["T"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["chair"] as! CALayer).animation(forKey: "chairAdientBrandingAnim"), theLayer:(layers["chair"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["chair3justseat"] as! CALayer).animation(forKey: "chair3justseatAdientBrandingAnim"), theLayer:(layers["chair3justseat"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["AisForAdientReversed"] as! CALayer).animation(forKey: "AisForAdientReversedAdientBrandingAnim"), theLayer:(layers["AisForAdientReversed"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["AdientSlantReversed"] as! CALayer).animation(forKey: "AdientSlantReversedAdientBrandingAnim"), theLayer:(layers["AdientSlantReversed"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["AdientSlantReversed2"] as! CALayer).animation(forKey: "AdientSlantReversed2AdientBrandingAnim"), theLayer:(layers["AdientSlantReversed2"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["crane_arm"] as! CALayer).animation(forKey: "crane_armAdientBrandingAnim"), theLayer:(layers["crane_arm"] as! CALayer))
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["seatback"] as! CALayer).animation(forKey: "seatbackAdientBrandingAnim"), theLayer:(layers["seatback"] as! CALayer))
		}
	}
	
	func removeAnimations(forAnimationId identifier: String){
		if identifier == "AdientBranding"{
			(layers["A"] as! CALayer).removeAnimation(forKey: "AAdientBrandingAnim")
			(layers["D"] as! CALayer).removeAnimation(forKey: "DAdientBrandingAnim")
			(layers["I"] as! CALayer).removeAnimation(forKey: "IAdientBrandingAnim")
			(layers["E"] as! CALayer).removeAnimation(forKey: "EAdientBrandingAnim")
			(layers["N"] as! CALayer).removeAnimation(forKey: "NAdientBrandingAnim")
			(layers["T"] as! CALayer).removeAnimation(forKey: "TAdientBrandingAnim")
			(layers["chair"] as! CALayer).removeAnimation(forKey: "chairAdientBrandingAnim")
			(layers["chair3justseat"] as! CALayer).removeAnimation(forKey: "chair3justseatAdientBrandingAnim")
			(layers["AisForAdientReversed"] as! CALayer).removeAnimation(forKey: "AisForAdientReversedAdientBrandingAnim")
			(layers["AdientSlantReversed"] as! CALayer).removeAnimation(forKey: "AdientSlantReversedAdientBrandingAnim")
			(layers["AdientSlantReversed2"] as! CALayer).removeAnimation(forKey: "AdientSlantReversed2AdientBrandingAnim")
			(layers["crane_arm"] as! CALayer).removeAnimation(forKey: "crane_armAdientBrandingAnim")
			(layers["seatback"] as! CALayer).removeAnimation(forKey: "seatbackAdientBrandingAnim")
		}
		self.layer.speed = 1
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
		self.layer.speed = 1
	}
	
	//MARK: - Bezier Path
	
	func APath(bounds: CGRect) -> UIBezierPath{
		let APath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		APath.move(to: CGPoint(x:minX + 0.76691 * w, y: minY + 0.87806 * h))
		APath.addLine(to: CGPoint(x:minX + 0.71544 * w, y: minY + 0.75669 * h))
		APath.addLine(to: CGPoint(x:minX + 0.27721 * w, y: minY + 0.75669 * h))
		APath.addLine(to: CGPoint(x:minX + 0.22574 * w, y: minY + 0.8807 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.17426 * w, y: minY + 0.97866 * h), controlPoint1:CGPoint(x:minX + 0.20564 * w, y: minY + 0.92907 * h), controlPoint2:CGPoint(x:minX + 0.18848 * w, y: minY + 0.96173 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.10441 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + 0.16005 * w, y: minY + 0.99559 * h), controlPoint2:CGPoint(x:minX + 0.13676 * w, y: minY + 1.00405 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.03162 * w, y: minY + 0.97701 * h), controlPoint1:CGPoint(x:minX + 0.07696 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.0527 * w, y: minY + 0.99504 * h))
		APath.addCurve(to: CGPoint(x:minX, y: minY + 0.91566 * h), controlPoint1:CGPoint(x:minX + 0.01054 * w, y: minY + 0.95898 * h), controlPoint2:CGPoint(x:minX, y: minY + 0.93853 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.00735 * w, y: minY + 0.87476 * h), controlPoint1:CGPoint(x:minX, y: minY + 0.90247 * h), controlPoint2:CGPoint(x:minX + 0.00245 * w, y: minY + 0.88884 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.03162 * w, y: minY + 0.81606 * h), controlPoint1:CGPoint(x:minX + 0.01225 * w, y: minY + 0.86069 * h), controlPoint2:CGPoint(x:minX + 0.02034 * w, y: minY + 0.84112 * h))
		APath.addLine(to: CGPoint(x:minX + 0.30735 * w, y: minY + 0.18809 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.33566 * w, y: minY + 0.12311 * h), controlPoint1:CGPoint(x:minX + 0.3152 * w, y: minY + 0.17006 * h), controlPoint2:CGPoint(x:minX + 0.32463 * w, y: minY + 0.1484 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.37096 * w, y: minY + 0.06012 * h), controlPoint1:CGPoint(x:minX + 0.34669 * w, y: minY + 0.09783 * h), controlPoint2:CGPoint(x:minX + 0.35846 * w, y: minY + 0.07683 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.42022 * w, y: minY + 0.01955 * h), controlPoint1:CGPoint(x:minX + 0.38346 * w, y: minY + 0.04341 * h), controlPoint2:CGPoint(x:minX + 0.39988 * w, y: minY + 0.02989 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.49559 * w, y: minY + 0.00405 * h), controlPoint1:CGPoint(x:minX + 0.44056 * w, y: minY + 0.00922 * h), controlPoint2:CGPoint(x:minX + 0.46569 * w, y: minY + 0.00405 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.57169 * w, y: minY + 0.01955 * h), controlPoint1:CGPoint(x:minX + 0.52598 * w, y: minY + 0.00405 * h), controlPoint2:CGPoint(x:minX + 0.55135 * w, y: minY + 0.00922 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.62096 * w, y: minY + 0.05946 * h), controlPoint1:CGPoint(x:minX + 0.59203 * w, y: minY + 0.02989 * h), controlPoint2:CGPoint(x:minX + 0.60846 * w, y: minY + 0.04319 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.65257 * w, y: minY + 0.1119 * h), controlPoint1:CGPoint(x:minX + 0.63346 * w, y: minY + 0.07573 * h), controlPoint2:CGPoint(x:minX + 0.644 * w, y: minY + 0.09321 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.68529 * w, y: minY + 0.18677 * h), controlPoint1:CGPoint(x:minX + 0.66115 * w, y: minY + 0.13059 * h), controlPoint2:CGPoint(x:minX + 0.67206 * w, y: minY + 0.15555 * h))
		APath.addLine(to: CGPoint(x:minX + 0.96691 * w, y: minY + 0.81078 * h))
		APath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.91434 * h), controlPoint1:CGPoint(x:minX + 0.98897 * w, y: minY + 0.85827 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.89279 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.96875 * w, y: minY + 0.97602 * h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.93677 * h), controlPoint2:CGPoint(x:minX + 0.98958 * w, y: minY + 0.95733 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.89338 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + 0.94792 * w, y: minY + 0.99471 * h), controlPoint2:CGPoint(x:minX + 0.92279 * w, y: minY + 1.00405 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.84926 * w, y: minY + 0.99581 * h), controlPoint1:CGPoint(x:minX + 0.87623 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.86152 * w, y: minY + 1.0013 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.81838 * w, y: minY + 0.97338 * h), controlPoint1:CGPoint(x:minX + 0.83701 * w, y: minY + 0.99031 * h), controlPoint2:CGPoint(x:minX + 0.82672 * w, y: minY + 0.98283 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.79154 * w, y: minY + 0.92984 * h), controlPoint1:CGPoint(x:minX + 0.81005 * w, y: minY + 0.96392 * h), controlPoint2:CGPoint(x:minX + 0.8011 * w, y: minY + 0.94941 * h))
		APath.addCurve(to: CGPoint(x:minX + 0.76691 * w, y: minY + 0.87806 * h), controlPoint1:CGPoint(x:minX + 0.78199 * w, y: minY + 0.91027 * h), controlPoint2:CGPoint(x:minX + 0.77377 * w, y: minY + 0.89301 * h))
		APath.close()
		APath.move(to: CGPoint(x:minX + 0.33456 * w, y: minY + 0.60959 * h))
		APath.addLine(to: CGPoint(x:minX + 0.65662 * w, y: minY + 0.60959 * h))
		APath.addLine(to: CGPoint(x:minX + 0.49412 * w, y: minY + 0.21052 * h))
		APath.close()
		APath.move(to: CGPoint(x:minX + 0.33456 * w, y: minY + 0.60959 * h))
		
		return APath
	}
	
	func DPath(bounds: CGRect) -> UIBezierPath{
		let DPath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		DPath.move(to: CGPoint(x:minX + 0.14525 * w, y: minY + 0.00405 * h))
		DPath.addLine(to: CGPoint(x:minX + 0.45411 * w, y: minY + 0.00405 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.66081 * w, y: minY + 0.02315 * h), controlPoint1:CGPoint(x:minX + 0.53445 * w, y: minY + 0.00405 * h), controlPoint2:CGPoint(x:minX + 0.60335 * w, y: minY + 0.01042 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.81724 * w, y: minY + 0.09477 * h), controlPoint1:CGPoint(x:minX + 0.71828 * w, y: minY + 0.03588 * h), controlPoint2:CGPoint(x:minX + 0.77042 * w, y: minY + 0.05976 * h))
		DPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.50132 * h), controlPoint1:CGPoint(x:minX + 0.93908 * w, y: minY + 0.18391 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.31942 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.98164 * w, y: minY + 0.66572 * h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.56135 * h), controlPoint2:CGPoint(x:minX + 0.99388 * w, y: minY + 0.61615 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.92498 * w, y: minY + 0.79975 * h), controlPoint1:CGPoint(x:minX + 0.96941 * w, y: minY + 0.71528 * h), controlPoint2:CGPoint(x:minX + 0.95052 * w, y: minY + 0.75996 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.82682 * w, y: minY + 0.90651 * h), controlPoint1:CGPoint(x:minX + 0.89944 * w, y: minY + 0.83954 * h), controlPoint2:CGPoint(x:minX + 0.86672 * w, y: minY + 0.87513 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.72386 * w, y: minY + 0.96449 * h), controlPoint1:CGPoint(x:minX + 0.79542 * w, y: minY + 0.93061 * h), controlPoint2:CGPoint(x:minX + 0.76111 * w, y: minY + 0.94994 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.60375 * w, y: minY + 0.99518 * h), controlPoint1:CGPoint(x:minX + 0.68662 * w, y: minY + 0.97904 * h), controlPoint2:CGPoint(x:minX + 0.64658 * w, y: minY + 0.98927 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.4589 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + 0.56092 * w, y: minY + 1.0011 * h), controlPoint2:CGPoint(x:minX + 0.51264 * w, y: minY + 1.00405 * h))
		DPath.addLine(to: CGPoint(x:minX + 0.15004 * w, y: minY + 1.00405 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.05267 * w, y: minY + 0.98734 * h), controlPoint1:CGPoint(x:minX + 0.10694 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.07449 * w, y: minY + 0.99848 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.00998 * w, y: minY + 0.94027 * h), controlPoint1:CGPoint(x:minX + 0.03086 * w, y: minY + 0.9762 * h), controlPoint2:CGPoint(x:minX + 0.01663 * w, y: minY + 0.96051 * h))
		DPath.addCurve(to: CGPoint(x:minX, y: minY + 0.86149 * h), controlPoint1:CGPoint(x:minX + 0.00333 * w, y: minY + 0.92004 * h), controlPoint2:CGPoint(x:minX, y: minY + 0.89377 * h))
		DPath.addLine(to: CGPoint(x:minX, y: minY + 0.1282 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.03432 * w, y: minY + 0.03338 * h), controlPoint1:CGPoint(x:minX, y: minY + 0.08454 * h), controlPoint2:CGPoint(x:minX + 0.01144 * w, y: minY + 0.05294 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.14525 * w, y: minY + 0.00405 * h), controlPoint1:CGPoint(x:minX + 0.0572 * w, y: minY + 0.01383 * h), controlPoint2:CGPoint(x:minX + 0.09417 * w, y: minY + 0.00405 * h))
		DPath.close()
		DPath.move(to: CGPoint(x:minX + 0.23703 * w, y: minY + 0.16435 * h))
		DPath.addLine(to: CGPoint(x:minX + 0.23703 * w, y: minY + 0.84307 * h))
		DPath.addLine(to: CGPoint(x:minX + 0.4166 * w, y: minY + 0.84307 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.50918 * w, y: minY + 0.84034 * h), controlPoint1:CGPoint(x:minX + 0.45597 * w, y: minY + 0.84307 * h), controlPoint2:CGPoint(x:minX + 0.48683 * w, y: minY + 0.84216 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.57861 * w, y: minY + 0.8267 * h), controlPoint1:CGPoint(x:minX + 0.53152 * w, y: minY + 0.83852 * h), controlPoint2:CGPoint(x:minX + 0.55467 * w, y: minY + 0.83397 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.64086 * w, y: minY + 0.796 * h), controlPoint1:CGPoint(x:minX + 0.60255 * w, y: minY + 0.81942 * h), controlPoint2:CGPoint(x:minX + 0.6233 * w, y: minY + 0.80919 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.75978 * w, y: minY + 0.49996 * h), controlPoint1:CGPoint(x:minX + 0.72014 * w, y: minY + 0.7387 * h), controlPoint2:CGPoint(x:minX + 0.75978 * w, y: minY + 0.64002 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.7075 * w, y: minY + 0.27827 * h), controlPoint1:CGPoint(x:minX + 0.75978 * w, y: minY + 0.40128 * h), controlPoint2:CGPoint(x:minX + 0.74235 * w, y: minY + 0.32738 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.57861 * w, y: minY + 0.18447 * h), controlPoint1:CGPoint(x:minX + 0.67265 * w, y: minY + 0.22915 * h), controlPoint2:CGPoint(x:minX + 0.62969 * w, y: minY + 0.19789 * h))
		DPath.addCurve(to: CGPoint(x:minX + 0.39346 * w, y: minY + 0.16435 * h), controlPoint1:CGPoint(x:minX + 0.52753 * w, y: minY + 0.17106 * h), controlPoint2:CGPoint(x:minX + 0.46582 * w, y: minY + 0.16435 * h))
		DPath.close()
		DPath.move(to: CGPoint(x:minX + 0.23703 * w, y: minY + 0.16435 * h))
		
		return DPath
	}
	
	func IPath(bounds: CGRect) -> UIBezierPath{
		let IPath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		IPath.move(to: CGPoint(x:minX, y: minY + 0.88466 * h))
		IPath.addLine(to: CGPoint(x:minX, y: minY + 0.12278 * h))
		IPath.addCurve(to: CGPoint(x:minX + 0.13805 * w, y: minY + 0.03373 * h), controlPoint1:CGPoint(x:minX, y: minY + 0.08321 * h), controlPoint2:CGPoint(x:minX + 0.04602 * w, y: minY + 0.05352 * h))
		IPath.addCurve(to: CGPoint(x:minX + 0.49495 * w, y: minY + 0.00405 * h), controlPoint1:CGPoint(x:minX + 0.23008 * w, y: minY + 0.01395 * h), controlPoint2:CGPoint(x:minX + 0.34905 * w, y: minY + 0.00405 * h))
		IPath.addCurve(to: CGPoint(x:minX + 0.86027 * w, y: minY + 0.0334 * h), controlPoint1:CGPoint(x:minX + 0.64534 * w, y: minY + 0.00405 * h), controlPoint2:CGPoint(x:minX + 0.76712 * w, y: minY + 0.01384 * h))
		IPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.12278 * h), controlPoint1:CGPoint(x:minX + 0.95342 * w, y: minY + 0.05297 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.08277 * h))
		IPath.addLine(to: CGPoint(x:minX + w, y: minY + 0.88466 * h))
		IPath.addCurve(to: CGPoint(x:minX + 0.86027 * w, y: minY + 0.97437 * h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.92468 * h), controlPoint2:CGPoint(x:minX + 0.95342 * w, y: minY + 0.95458 * h))
		IPath.addCurve(to: CGPoint(x:minX + 0.49495 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + 0.76712 * w, y: minY + 0.99416 * h), controlPoint2:CGPoint(x:minX + 0.64534 * w, y: minY + 1.00405 * h))
		IPath.addCurve(to: CGPoint(x:minX + 0.13973 * w, y: minY + 0.97404 * h), controlPoint1:CGPoint(x:minX + 0.35129 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.23288 * w, y: minY + 0.99405 * h))
		IPath.addCurve(to: CGPoint(x:minX, y: minY + 0.88466 * h), controlPoint1:CGPoint(x:minX + 0.04658 * w, y: minY + 0.95403 * h), controlPoint2:CGPoint(x:minX, y: minY + 0.92424 * h))
		IPath.close()
		IPath.move(to: CGPoint(x:minX, y: minY + 0.88466 * h))
		
		return IPath
	}
	
	func EPath(bounds: CGRect) -> UIBezierPath{
		let EPath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		EPath.move(to: CGPoint(x:minX + 0.85487 * w, y: minY + 0.16026 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.26283 * w, y: minY + 0.16026 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.26283 * w, y: minY + 0.40582 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.80796 * w, y: minY + 0.40582 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.89779 * w, y: minY + 0.42663 * h), controlPoint1:CGPoint(x:minX + 0.84808 * w, y: minY + 0.40582 * h), controlPoint2:CGPoint(x:minX + 0.87802 * w, y: minY + 0.41276 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.92743 * w, y: minY + 0.48154 * h), controlPoint1:CGPoint(x:minX + 0.91755 * w, y: minY + 0.4405 * h), controlPoint2:CGPoint(x:minX + 0.92743 * w, y: minY + 0.4588 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.89823 * w, y: minY + 0.53713 * h), controlPoint1:CGPoint(x:minX + 0.92743 * w, y: minY + 0.50428 * h), controlPoint2:CGPoint(x:minX + 0.9177 * w, y: minY + 0.52281 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.80796 * w, y: minY + 0.55862 * h), controlPoint1:CGPoint(x:minX + 0.87876 * w, y: minY + 0.55146 * h), controlPoint2:CGPoint(x:minX + 0.84867 * w, y: minY + 0.55862 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.26283 * w, y: minY + 0.55862 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.26283 * w, y: minY + 0.84307 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.87522 * w, y: minY + 0.84307 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.96858 * w, y: minY + 0.86524 * h), controlPoint1:CGPoint(x:minX + 0.91652 * w, y: minY + 0.84307 * h), controlPoint2:CGPoint(x:minX + 0.94764 * w, y: minY + 0.85046 * h))
		EPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.92424 * h), controlPoint1:CGPoint(x:minX + 0.98953 * w, y: minY + 0.88002 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.89969 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.96858 * w, y: minY + 0.98188 * h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.94789 * h), controlPoint2:CGPoint(x:minX + 0.98953 * w, y: minY + 0.9671 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.87522 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + 0.94764 * w, y: minY + 0.99666 * h), controlPoint2:CGPoint(x:minX + 0.91652 * w, y: minY + 1.00405 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.16106 * w, y: minY + 1.00405 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.03761 * w, y: minY + 0.97472 * h), controlPoint1:CGPoint(x:minX + 0.10383 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.06268 * w, y: minY + 0.99427 * h))
		EPath.addCurve(to: CGPoint(x:minX, y: minY + 0.8799 * h), controlPoint1:CGPoint(x:minX + 0.01254 * w, y: minY + 0.95517 * h), controlPoint2:CGPoint(x:minX, y: minY + 0.92356 * h))
		EPath.addLine(to: CGPoint(x:minX, y: minY + 0.1282 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.01681 * w, y: minY + 0.05692 * h), controlPoint1:CGPoint(x:minX, y: minY + 0.09909 * h), controlPoint2:CGPoint(x:minX + 0.0056 * w, y: minY + 0.07533 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.06947 * w, y: minY + 0.01667 * h), controlPoint1:CGPoint(x:minX + 0.02802 * w, y: minY + 0.0385 * h), controlPoint2:CGPoint(x:minX + 0.04558 * w, y: minY + 0.02508 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.16106 * w, y: minY + 0.00405 * h), controlPoint1:CGPoint(x:minX + 0.09336 * w, y: minY + 0.00826 * h), controlPoint2:CGPoint(x:minX + 0.12389 * w, y: minY + 0.00405 * h))
		EPath.addLine(to: CGPoint(x:minX + 0.85487 * w, y: minY + 0.00405 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.94823 * w, y: minY + 0.02554 * h), controlPoint1:CGPoint(x:minX + 0.89676 * w, y: minY + 0.00405 * h), controlPoint2:CGPoint(x:minX + 0.92788 * w, y: minY + 0.01121 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.97876 * w, y: minY + 0.08181 * h), controlPoint1:CGPoint(x:minX + 0.96858 * w, y: minY + 0.03986 * h), controlPoint2:CGPoint(x:minX + 0.97876 * w, y: minY + 0.05862 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.94823 * w, y: minY + 0.13877 * h), controlPoint1:CGPoint(x:minX + 0.97876 * w, y: minY + 0.10546 * h), controlPoint2:CGPoint(x:minX + 0.96858 * w, y: minY + 0.12445 * h))
		EPath.addCurve(to: CGPoint(x:minX + 0.85487 * w, y: minY + 0.16026 * h), controlPoint1:CGPoint(x:minX + 0.92788 * w, y: minY + 0.1531 * h), controlPoint2:CGPoint(x:minX + 0.89676 * w, y: minY + 0.16026 * h))
		EPath.close()
		EPath.move(to: CGPoint(x:minX + 0.85487 * w, y: minY + 0.16026 * h))
		
		return EPath
	}
	
	func NPath(bounds: CGRect) -> UIBezierPath{
		let NPath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		NPath.move(to: CGPoint(x:minX + 0.31214 * w, y: minY + 0.12147 * h))
		NPath.addLine(to: CGPoint(x:minX + 0.77751 * w, y: minY + 0.69139 * h))
		NPath.addLine(to: CGPoint(x:minX + 0.77751 * w, y: minY + 0.11619 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.80725 * w, y: minY + 0.03209 * h), controlPoint1:CGPoint(x:minX + 0.77751 * w, y: minY + 0.07881 * h), controlPoint2:CGPoint(x:minX + 0.78742 * w, y: minY + 0.05077 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.88753 * w, y: minY + 0.00405 * h), controlPoint1:CGPoint(x:minX + 0.82709 * w, y: minY + 0.0134 * h), controlPoint2:CGPoint(x:minX + 0.85384 * w, y: minY + 0.00405 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.96985 * w, y: minY + 0.03209 * h), controlPoint1:CGPoint(x:minX + 0.9223 * w, y: minY + 0.00405 * h), controlPoint2:CGPoint(x:minX + 0.94974 * w, y: minY + 0.0134 * h))
		NPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.11619 * h), controlPoint1:CGPoint(x:minX + 0.98995 * w, y: minY + 0.05077 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.07881 * h))
		NPath.addLine(to: CGPoint(x:minX + w, y: minY + 0.87674 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.8696 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.96162 * h), controlPoint2:CGPoint(x:minX + 0.95653 * w, y: minY + 1.00405 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.81092 * w, y: minY + 0.99647 * h), controlPoint1:CGPoint(x:minX + 0.84787 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.82831 * w, y: minY + 1.00152 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.76202 * w, y: minY + 0.97239 * h), controlPoint1:CGPoint(x:minX + 0.79353 * w, y: minY + 0.99141 * h), controlPoint2:CGPoint(x:minX + 0.77723 * w, y: minY + 0.98338 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.71964 * w, y: minY + 0.9338 * h), controlPoint1:CGPoint(x:minX + 0.74681 * w, y: minY + 0.96139 * h), controlPoint2:CGPoint(x:minX + 0.73268 * w, y: minY + 0.94853 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.68052 * w, y: minY + 0.88862 * h), controlPoint1:CGPoint(x:minX + 0.7066 * w, y: minY + 0.91907 * h), controlPoint2:CGPoint(x:minX + 0.69356 * w, y: minY + 0.90401 * h))
		NPath.addLine(to: CGPoint(x:minX + 0.22657 * w, y: minY + 0.32529 * h))
		NPath.addLine(to: CGPoint(x:minX + 0.22657 * w, y: minY + 0.89191 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.19478 * w, y: minY + 0.97569 * h), controlPoint1:CGPoint(x:minX + 0.22657 * w, y: minY + 0.92885 * h), controlPoint2:CGPoint(x:minX + 0.21597 * w, y: minY + 0.95678 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.11328 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + 0.17359 * w, y: minY + 0.9946 * h), controlPoint2:CGPoint(x:minX + 0.14643 * w, y: minY + 1.00405 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.03097 * w, y: minY + 0.97536 * h), controlPoint1:CGPoint(x:minX + 0.07905 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.05162 * w, y: minY + 0.99449 * h))
		NPath.addCurve(to: CGPoint(x:minX, y: minY + 0.89191 * h), controlPoint1:CGPoint(x:minX + 0.01032 * w, y: minY + 0.95623 * h), controlPoint2:CGPoint(x:minX, y: minY + 0.92841 * h))
		NPath.addLine(to: CGPoint(x:minX, y: minY + 0.14587 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.01304 * w, y: minY + 0.07133 * h), controlPoint1:CGPoint(x:minX, y: minY + 0.11421 * h), controlPoint2:CGPoint(x:minX + 0.00435 * w, y: minY + 0.08936 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.06438 * w, y: minY + 0.02285 * h), controlPoint1:CGPoint(x:minX + 0.02336 * w, y: minY + 0.05154 * h), controlPoint2:CGPoint(x:minX + 0.04048 * w, y: minY + 0.03538 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.14181 * w, y: minY + 0.00405 * h), controlPoint1:CGPoint(x:minX + 0.08829 * w, y: minY + 0.01032 * h), controlPoint2:CGPoint(x:minX + 0.1141 * w, y: minY + 0.00405 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.19764 * w, y: minY + 0.01263 * h), controlPoint1:CGPoint(x:minX + 0.16354 * w, y: minY + 0.00405 * h), controlPoint2:CGPoint(x:minX + 0.18215 * w, y: minY + 0.00691 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.23839 * w, y: minY + 0.03571 * h), controlPoint1:CGPoint(x:minX + 0.21312 * w, y: minY + 0.01834 * h), controlPoint2:CGPoint(x:minX + 0.2267 * w, y: minY + 0.02604 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.27425 * w, y: minY + 0.07331 * h), controlPoint1:CGPoint(x:minX + 0.25007 * w, y: minY + 0.04539 * h), controlPoint2:CGPoint(x:minX + 0.26202 * w, y: minY + 0.05792 * h))
		NPath.addCurve(to: CGPoint(x:minX + 0.31214 * w, y: minY + 0.12147 * h), controlPoint1:CGPoint(x:minX + 0.28647 * w, y: minY + 0.0887 * h), controlPoint2:CGPoint(x:minX + 0.2991 * w, y: minY + 0.10475 * h))
		NPath.close()
		NPath.move(to: CGPoint(x:minX + 0.31214 * w, y: minY + 0.12147 * h))
		
		return NPath
	}
	
	func TPath(bounds: CGRect) -> UIBezierPath{
		let TPath = UIBezierPath()
		let minX = CGFloat(bounds.minX), minY = bounds.minY, w = bounds.width, h = bounds.height;
		
		TPath.move(to: CGPoint(x:minX + 0.87801 * w, y: minY + 0.16837 * h))
		TPath.addLine(to: CGPoint(x:minX + 0.61798 * w, y: minY + 0.16837 * h))
		TPath.addLine(to: CGPoint(x:minX + 0.61798 * w, y: minY + 0.88266 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.58507 * w, y: minY + 0.97421 * h), controlPoint1:CGPoint(x:minX + 0.61798 * w, y: minY + 0.92379 * h), controlPoint2:CGPoint(x:minX + 0.60701 * w, y: minY + 0.95431 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.5 * w, y: minY + 1.00405 * h), controlPoint1:CGPoint(x:minX + 0.56314 * w, y: minY + 0.9941 * h), controlPoint2:CGPoint(x:minX + 0.53478 * w, y: minY + 1.00405 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.41372 * w, y: minY + 0.97387 * h), controlPoint1:CGPoint(x:minX + 0.46469 * w, y: minY + 1.00405 * h), controlPoint2:CGPoint(x:minX + 0.43593 * w, y: minY + 0.99399 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.38042 * w, y: minY + 0.88266 * h), controlPoint1:CGPoint(x:minX + 0.39152 * w, y: minY + 0.95375 * h), controlPoint2:CGPoint(x:minX + 0.38042 * w, y: minY + 0.92334 * h))
		TPath.addLine(to: CGPoint(x:minX + 0.38042 * w, y: minY + 0.16837 * h))
		TPath.addLine(to: CGPoint(x:minX + 0.12039 * w, y: minY + 0.16837 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.0297 * w, y: minY + 0.1459 * h), controlPoint1:CGPoint(x:minX + 0.07972 * w, y: minY + 0.16837 * h), controlPoint2:CGPoint(x:minX + 0.04949 * w, y: minY + 0.16088 * h))
		TPath.addCurve(to: CGPoint(x:minX, y: minY + 0.08655 * h), controlPoint1:CGPoint(x:minX + 0.0099 * w, y: minY + 0.13092 * h), controlPoint2:CGPoint(x:minX, y: minY + 0.11114 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.0309 * w, y: minY + 0.02618 * h), controlPoint1:CGPoint(x:minX, y: minY + 0.06106 * h), controlPoint2:CGPoint(x:minX + 0.0103 * w, y: minY + 0.04094 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.12039 * w, y: minY + 0.00405 * h), controlPoint1:CGPoint(x:minX + 0.0515 * w, y: minY + 0.01143 * h), controlPoint2:CGPoint(x:minX + 0.08133 * w, y: minY + 0.00405 * h))
		TPath.addLine(to: CGPoint(x:minX + 0.87801 * w, y: minY + 0.00405 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.9699 * w, y: minY + 0.02685 * h), controlPoint1:CGPoint(x:minX + 0.91921 * w, y: minY + 0.00405 * h), controlPoint2:CGPoint(x:minX + 0.94984 * w, y: minY + 0.01165 * h))
		TPath.addCurve(to: CGPoint(x:minX + w, y: minY + 0.08655 * h), controlPoint1:CGPoint(x:minX + 0.98997 * w, y: minY + 0.04206 * h), controlPoint2:CGPoint(x:minX + w, y: minY + 0.06195 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.9695 * w, y: minY + 0.1459 * h), controlPoint1:CGPoint(x:minX + w, y: minY + 0.11114 * h), controlPoint2:CGPoint(x:minX + 0.98983 * w, y: minY + 0.13092 * h))
		TPath.addCurve(to: CGPoint(x:minX + 0.87801 * w, y: minY + 0.16837 * h), controlPoint1:CGPoint(x:minX + 0.94917 * w, y: minY + 0.16088 * h), controlPoint2:CGPoint(x:minX + 0.91867 * w, y: minY + 0.16837 * h))
		TPath.close()
		TPath.move(to: CGPoint(x:minX + 0.87801 * w, y: minY + 0.16837 * h))
		
		return TPath
	}
	
	
}
