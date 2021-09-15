//
//  Strings.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 30/7/21.
//

struct Strings {
    
    struct ViewControllerID {
        static let homeVCID: String = "homeVCID"
        static let startingScreenVCID: String = "startingScreenVCID"
        static let vanGoghFiltersVCID: String = "vanGoghFiltersVCID"
    }
    
    struct Nib {
        static let VanGoghCollectionViewCell: String = "VanGoghCollectionViewCell"
    }
    
    struct Cell {
        static let vanGoghCollectionViewCellID: String = "vanGoghCollectionViewCellID"
    }
    
    struct SegmentedControl {
        static let vanGogh: String = "Van Gogh"
        static let original: String = "Original"
    }
    
    struct Buttons {
        static let save: String = "Save"
        static let add: String = "Add"
        static let choose: String = "Choose"
        static let chooseStyle: String = "Change Style"
        static let filters: String = "Filters"
    }
    
    struct Filter {
        static let sharpness: String = "CIUnsharpMask"
    }
    
    struct Font {
        static let regular: String = "Montserrat-Regular"
        static let medium: String = "Montserrat-Medium"
        static let light: String = "Montserrat-Light"
        static let bold: String = "Montserrat-Bold"
        static let black: String = "Montserrat-Black"
        static let italic: String = "Montserrat-Italic"
        static let mediumItalic: String = "Montserrat-MediumItalic"
        static let lightItalic: String = "Montserrat-LightItalic"
        static let boldItalic: String = "Montserrat-BoldItalic"
        static let blackItalic: String = "Montserrat-BlackItalic"
    }
    
    struct Image {
        static let titleImage: String = "VanGoghTitle"
    }
    
    struct Alert {
        static let successSavingTitle: String = "Done!"
        static let successSavingMessage: String = "Photo successfully saved to your library."
        static let failedTitle: String = "Oops!"
        static let failedSavingMessage: String = "Something went wrong trying to save to your library."
        static let failedImportingMessage: String = "Something went wrong importing photo."
        static let failedImportingImageMessage: String = "This image file type not supported"
        static let chooseImageFrom: String = "Choose image from"
        static let cameraAction: String = "Camera"
        static let galleryAction: String = "Gallery"
        static let cancel: String = "Cancel"
    }
    
    struct VanGogh {
        struct StarryNight {
            static let imageName: String = "starryNightImage"
            static let name: String = "Starry Night"
            static let info: String = "The Starry Night is an oil-on-canvas painting by the Dutch Post-Impressionist painter Vincent van Gogh. Painted in June 1889, it depicts the view from the east-facing window of his asylum room at Saint-Rémy-de-Provence, just before sunrise, with the addition of an imaginary village. It has been in the permanent collection of the Museum of Modern Art in New York City since 1941, acquired through the Lillie P. Bliss Bequest. Widely regarded as Van Gogh's magnum opus, the Starry Night is one of the most recognized paintings in Western art."
        }
        
        struct CafeTerrace {
            static let imageName: String = "cafeTerraceImage"
            static let name: String = "Cafe Terrace"
            static let info: String = "Van Gogh painted Café Terrace at Night in Arles, France, in mid-September 1888. Visitors to the site can stand at the north eastern corner of the Place du Forum, where the artist set up his easel. The site was refurbished in 1990 and 1991 to replicate van Gogh's painting. Towards the right, Van Gogh indicated a lighted shop and some branches of the trees surrounding the place, but he omitted the remainders of the Roman monuments just beside this little shop. The painting is currently at the Kröller-Müller Museum in Otterlo, Netherlands."
        }
        
        struct AlmondBlossom {
            static let imageName: String = "almondBlossomImage"
            static let name: String = "Almond Blossom"
            static let info: String = "Almond Blossoms is a group of several paintings made in 1888 and 1890 by Vincent van Gogh in Arles and Saint-Rémy, southern France of blossoming almond trees. Flowering trees were special to van Gogh. They represented awakening and hope. He enjoyed them aesthetically and found joy in painting flowering trees. The works reflect the influence of Impressionism, Divisionism, and Japanese woodcuts. Almond Blossom was made to celebrate the birth of his nephew and namesake, son of his brother Theo and sister-in-law Jo."
        }
        
        struct PotatoEaters {
            static let imageName: String = "potatoEatersImage"
            static let name: String = "Potato Eaters"
            static let info: String = "The Potato Eaters (Dutch: De Aardappeleters) is an oil painting by Dutch artist Vincent van Gogh painted in April 1885 in Nuenen, Netherlands. It is in the Van Gogh Museum in Amsterdam. The original oil sketch of the painting is at the Kröller-Müller Museum in Otterlo, and he also made lithographs of the image, which are held in collections including the Museum of Modern Art in New York City. The painting is considered to be one of Van Gogh's masterpieces."
        }
        
    }
    
    static let startingLabelText: String = "Pick or capture a photo to get started!"
    static let intensity: String = "Intensity"
    static let chooseFilter: String = "Choose Filter"
    static let chooseVanGogh: String = "Choose a Van Gogh Painting"
}
