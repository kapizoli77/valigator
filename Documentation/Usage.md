# Introduction
Valigator provides a clean and smart way to validate forms with any type of input. It's perfectly suited to use for complicated validation logic. You can look into iOS Example app in Valigator.xcworkspace to see how Valigator works in action.

# Basic Usage
## Example for a small MVC project
Create an instance from Validator with the required [validation strategy](https://kapizoli77.github.io/valigator/Enums/ValidationStrategy.html):

```swift
let valigator: Valigator(validationStrategy: .endOfField)
```

Set [delegate](https://kapizoli77.github.io/valigator/Protocols/ValigatorDelegate.html) and [dataSource](https://kapizoli77.github.io/valigator/Protocols/ValigatorDataSource.html) of Valigator, and implement these protocols:

```swift
class ExampleVC: UIViewController {
    let valigator: Valigator(validationStrategy: .endOfField)

    override func viewDidLoad() {
        super.viewDidLoad()

        registerValigator()
    }

    func registerValigator() {
        valigator.delegate = self
        valigator.dataSource = self
    }
}

extension ExampleVC: ValigatorDelegate {
    func fieldValidationDidEnd(fieldId: Int, success: Bool, validationRuleResults: [ValidationRuleResult]) {
        ...
    }
}

extension ExampleVC: ValigatorDataSource {
    func validatableValue<InputType>(for fieldId: Int) throws -> InputType {
        ...
    }
}
```

Register fields with rules and identifiers:

> **_NOTE:_** Identifier should be not 0. For example if you use it as UIView tag property, the default 0 tag is a potentional bug.

```swift
class ExampleVC: UIViewController {
    @IBOutlet private var firstTextField: UITextField!
    @IBOutlet private var secondTextField: UITextField!

    func registerValigator() {
        valigator.delegate = self
        valigator.dataSource = self

        // Register first textField
        let firstFieldTag = 1
        let requiredRule = RequiredStringValidationRule(message: "This field is required")
        let firstField = FieldValidationModel(fieldId: , rules: [requiredRule])
        valigator.registerField(firstField)
        firstTextField.tag = firstFieldTag

        // Register second textField
        let secondFieldTag = 2
        let secondField = FieldValidationModel(fieldId: , rules: [requiredRule])
        valigator.registerField(secondField)
        secondTextField.tag = secondFieldTag
    }
}
```

Tell the Valigator if a field's value changes.

```swift
class ExampleVC: UIViewController {
    ...
    func registerValigator() {
        ...

        firstTextField.delegate = self
        firstTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        secondTextField.delegate = self
        secondTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard textField.tag == 1 || textField.tag == 2 else {
            debugPrint("Unhandled field tag: \(textField.tag)")
            return
        }

        valigator.editStateDidChanged(fieldId: textField.tag, isActive: true)
    }
}

extension InputFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField.tag == 1 || textField.tag == 2 else {
            debugPrint("Unhandled field tag: \(textField.tag)")
            return
        }

        valigator.editStateDidChanged(fieldId: textField.tag, isActive: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.tag == 1 || textField.tag == 2 else {
            debugPrint("Unhandled field tag: \(textField.tag)")
            return
        }

        valigator.editStateDidChanged(fieldId: textField.tag, isActive: false)
    }
}
```

## Custom validation rule

If it's necessary you can create your own validation rules. All rule have to to implement __ValidationRuleProtocol__.
All rule has a message property with a detailed error message and a validate method with a boolean return value which shows the success of the validation.

For example, you can use [PhoneNumberKit framework](https://github.com/marmelroy/PhoneNumberKit) to validate a phone number.

```swift
import PhoneNumberKit
import Valigator

public class PhoneNumberValidationRule: BaseValidationRule<String?> {
    // MARK: - Properties

    public var region: String
    private let phoneNumberKit = PhoneNumberKit()

    // MARK: - Initialization

    public init(message: String, region: String = PhoneNumberKit.defaultRegionCode()) {
        self.region = region

        super.init(message: message)
    }

    // MARK: - BaseValidationRule functions

    public override func validate(value: String?) -> Bool {
        guard let value = PhoneNumberValidationRule.removeSpaces(from: value), !value.isEmpty else { return false }

        do {
            _ = try phoneNumberKit.parse(value)
            return true
        } catch {
            return false
        }
    }

    // MARK: - Functions
    public static func removeSpaces(from originalString: String?) -> String? {
        return originalString?.replacingOccurrences(of: " ", with: "")
    }
}
```

## CrossField validation
``` swift
func registerValigator() {
        ...
    let repeatEmailRule = CrossFieldValidationRule(
        relatedFieldIds: [1, 2],
        validateClosure: { [weak self] in
            guard let self = self else { return }

            if let firstEmail = self.validatableValue(for: 1), 
             let secondEmail = self.validatableValue(for: 2),
             firstEmail == secondEmail {
                // Emails are equals, hide error
            } else {
                // Emails are not equals, show error
            }
        }
    )
    valigator.registerCrossFieldInputRule(crossFieldInputRule: repeatEmailRule)
}
```

# Advanced Usage
## Usage in a table view

See in example app
Description: later

## FieldValueManager usage

See in example app
Description: later



## Custom validation strategy

Description: later
