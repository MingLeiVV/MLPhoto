//
//  MLPhotoChooseController.swift
//  MLPhoto
//
//  Created by 吴明磊 on 15/8/8.
//  Copyright © 2015年 wuminglei. All rights reserved.
//

import UIKit

private let photoChooseIdentifier = "photoChooseIdentifier"
private var maxPhotoCount = 9
private let bundelPath = NSBundle.mainBundle().pathForResource("temp", ofType: "bundle");

class MLPhotoChooseController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        self.collectionView!.registerClass(PhotoChooseCell.self, forCellWithReuseIdentifier: photoChooseIdentifier)


        
    }
    init() {
    
        super.init(collectionViewLayout: photoChooseFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 记录选中cell的索引
    private var currentIndex = 0
     var images = [UIImage]()

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return images.count == maxPhotoCount ? maxPhotoCount : images.count + 1
        
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoChooseIdentifier, forIndexPath: indexPath) as! PhotoChooseCell
    
        
        cell.backgroundColor = UIColor.blueColor()
        
        cell.delegate = self
        
        cell.setupUI()
        
        
        
        let index = indexPath.item
        
        cell.image = images.count == index ? nil : images[index]
        
        
        return cell
    }
   
  

}
extension MLPhotoChooseController : photoChooseDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   // 添加照片
    private func photoChooseAddPhoto(ChooseCell: PhotoChooseCell) {
        
        let index = collectionView?.indexPathForCell(ChooseCell)
        
        currentIndex = index!.item
        
        let picker = UIImagePickerController()
        
        
        picker.delegate = self
        
       if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
        
          print("无法访问相册")
        
          return
        }

        presentViewController(picker, animated: true, completion: nil)
        

        
        
        
    }
    // 移除照片
    private func photoChooseRemovePhoto(ChooseCell: PhotoChooseCell) {
        
        let indexPath = collectionView?.indexPathForCell(ChooseCell)
        
 
        images.removeAtIndex(indexPath!.item)
        
        collectionView?.reloadData()

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        
        let indexPath = NSIndexPath(forItem: currentIndex, inSection: 0)
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? PhotoChooseCell
        
        guard let img : UIImage = image else {
        
            print("图片获取失败")
            return
        }
        
       let scaleImg = img.compressImage(300)
        
        cell?.image = scaleImg
        
        if images.count == currentIndex {
            
         images.append(scaleImg)
            
        } else {
         
            images[currentIndex] = scaleImg
            
        }
        

        collectionView?.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
/// photo的代理
private protocol photoChooseDelegate : NSObjectProtocol {

    func photoChooseAddPhoto (ChooseCell : PhotoChooseCell)
     func photoChooseRemovePhoto (ChooseCell : PhotoChooseCell)
}
private class PhotoChooseCell : UICollectionViewCell {

    
  private  weak var delegate : photoChooseDelegate?
    
    private var image : UIImage? {
    
        didSet{
    
            
            addPhotoBtn.setImage(image == nil ? UIImage(named: "compose_pic_add") : image, forState: UIControlState.Normal)
            
            removeBtn.hidden = image == nil ? true : false
        }
    }
    
    private func setupUI () {
    
        contentView.addSubview(addPhotoBtn)
        contentView.addSubview(removeBtn)
        
        prepareAddBtn()
        prepareRemoveBtn()
        
    }
    
  @objc  private func addPhoto () {
    
    delegate?.photoChooseAddPhoto(self)
    
    
    
    }
    
  @objc  private func removePhoto () {
        
        delegate?.photoChooseRemovePhoto(self)
    }
    
    private func prepareAddBtn () {
        
        addPhotoBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[add]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["add" : addPhotoBtn]))
         contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[add]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["add" : addPhotoBtn]))
    
    }
    private func prepareRemoveBtn () {
        
        removeBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[remove]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["remove" : removeBtn]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[remove]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["remove" : removeBtn]))
    }
    
    private lazy var addPhotoBtn : UIButton = UIButton(target: self, action: "addPhoto", image: bundelPath!.stringByAppendingPathComponent("compose_pic_add"))
    private lazy var removeBtn : UIButton = UIButton(target: self, action: "removePhoto", image: bundelPath!.stringByAppendingPathComponent("compose_photo_close"))
}

private class photoChooseFlowLayout : UICollectionViewFlowLayout {

    private override func prepareLayout() {
        
        itemSize = CGSize(width: 80, height: 80)
        
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView?.backgroundColor = UIColor.whiteColor()
    }
}
