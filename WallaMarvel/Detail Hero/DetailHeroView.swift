import UIKit
import Kingfisher

final class DetailHeroView: UIView {
    struct Attributes {
        static let contentInsets: CGFloat = 16
        static let imageSize: CGFloat = 60
        static let titleSpacing: CGFloat = 16
        static let contentSpacing: CGFloat = 16
    }

    private let nameLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = [.link]
        return textView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.tintColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let heroeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Attributes.imageSize/2
        return imageView
    }()

    private let exampleComicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()


    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Attributes.titleSpacing
        stackView.alignment = .leading
        return stackView
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Attributes.contentSpacing
        return stack
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground
        titleStackView.addArrangedSubview(heroeImageView)
        titleStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(titleStackView)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(exampleComicLabel)

        addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Attributes.contentInsets),
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Attributes.contentInsets),
            contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Attributes.contentInsets),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -Attributes.contentInsets),

            heroeImageView.widthAnchor.constraint(equalToConstant: Attributes.imageSize),
            heroeImageView.heightAnchor.constraint(equalToConstant: Attributes.imageSize)
        ])
    }

    func configure(model: CharacterDetailDataModel) {
        heroeImageView.kf.setImage(
            with: URL(string: model.thumbnail.path + "/portrait_medium." + model.thumbnail.extension),
            placeholder: UIImage(systemName: "photo")
        )
        configureName(model: model)
        configureComic(model: model.comics.items)
        descriptionLabel.text = model.description
        self.accessibilityIdentifier = ("\(model.name) Detail Hero View")
    }

    func configureName(model: CharacterDetailDataModel) {
        let link = "https://es.wallapop.com/app/search?keywords=\(model.name)"
        let attributes: [NSAttributedString.Key: Any] = [
            .link: link,
            .font: UIFont.boldSystemFont(ofSize: 42),
            .foregroundColor: UIColor.link
        ]
        let nameURL = NSAttributedString(string: model.name, attributes: attributes)
        nameLabel.attributedText = nameURL
    }

    func configureComic(model: [ComicItem]) {
        guard let comicName = model.randomElement()?.name else {
            exampleComicLabel.text = "No comic available"
            return
        }

        let prefix = "Random Comic: "
        let fullText = prefix + comicName
        let link = "https://es.wallapop.com/app/search?keywords=\(comicName)"

        let attributedText = NSMutableAttributedString(string: fullText)

        attributedText.addAttributes([
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: NSRange(location: prefix.count, length: comicName.count))

        exampleComicLabel.attributedText = attributedText

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapComicLabel))
        exampleComicLabel.addGestureRecognizer(tap)
        exampleComicLabel.accessibilityHint = link
    }


    @objc private func didTapComicLabel() {
        guard let urlString = exampleComicLabel.accessibilityHint,
              let url = URL(string: urlString) else { return }

        UIApplication.shared.open(url)
    }

}
