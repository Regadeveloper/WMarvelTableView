import UIKit
import Kingfisher

final class DetailHeroView: UIView {
    struct Attributes {
        static let contentInsets: CGFloat = 16
        static let imageSize: CGFloat = 60
        static let titleSpacing: CGFloat = 16
        static let contentSpacing: CGFloat = 16
    }

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Attributes.contentSpacing
        return stack
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 42)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
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


    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Attributes.titleSpacing
        stackView.alignment = .leading
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        titleStackView.addArrangedSubview(heroeImageView)
        titleStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(titleStackView)
        contentStackView.addArrangedSubview(descriptionLabel)

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
        let processor = RoundCornerImageProcessor(cornerRadius: Attributes.imageSize/2)
        heroeImageView.kf.setImage(
            with: URL(string: model.thumbnail.path + "/portrait_medium." + model.thumbnail.extension),
            placeholder: UIImage(systemName: "photo"),
            options: [.processor(processor)]
        )
        nameLabel.text = model.name
        descriptionLabel.text = model.description
    }
}
