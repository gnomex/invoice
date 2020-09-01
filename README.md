# Invoice Generator

This is a POC trying to exemplify an approach for a dynamic **Pricing Policy** based on some criteria

## Design

Suppose you have your ecommerce subscription engine modeled as:

* a subscription table with all data about the payable plan
* user account having an subscription configuration
* your pricing depends on some dynamic "on the fly" values

- **The Pricing Policy**

There are some kinds of subscription, like `Flexible`, `Fixed` and `Prestige`, and a pricing calculator defined as `base_price + margin`.

The `margin` is tied to "on the fly" thing. The basic idea is that the each kind will have an url and a word, where it will count all word (a single character, sequence or elements) occurrences on the page url, and it could be any kind, like html, xml, json.
After the count, an extra math operation could be assigned, like, the `margin` is the how many words `ruby` you find divided by `100` -- or any other kind of math stuff.

...Back to Design...

Based on my experience with payment systems, I think it will best to have a dynamic and desacopled way to create the invoice based on service objects and a strategy pattern. I would like to alter my subscription data and all subsystem getting adaptaded to that, without to change any source code.
Well, its ruby, we can create some metaprogramming magic, but for the sake of matter, thinking in a example, I keept some harded coded stuff in concrete strategy classes.

> keep in mind all the code is a PoC, and there a tons of optimizations we could do

### Lets go to the code

To calculate the invoice, you'll use a `BillCalculator` passing the account reference, its responsability is to find the account subscription and invoke the `PricingPolicy`.

The `PricingPolicy` responsibility is to identify the Subscription type and invoke the concrete class by a strategy pattern.

On this example, the strategies are organized in a `Billable` module scope. They are `Billable::Fixed`, `Billable::Flexible` and `Billable::Prestige`.
They are all subclass of `Billable::Base`, that defines the basic API.

By your turn, the strategy class will have the configurations and params to load the data, apply the math, sum with `base_price` and return the invoice value -- so simple and beauty.

To load the data, there is the `Billable::DynamicFactorCalculator` service to open the URL, parse the content, and return the word/element count.

I'm using the amazing [Mechanize](https://github.com/sparklemotion/mechanize) gem.

The workflow implemented shows the basic structure, a guideline, and simply return the invoice value, in a real world example you'll have some other things to load, maybe extra charges, descriptions, etc.

#### In short

There is a `BillCalculator` that will receive an account, get their subscription data, and delegate to `PricingPolicy` to do the magic. The `PricingPolicy` are going to find the right service class, under `Billable` module, and put it to work.

Both `Billable` implementations knows the money transformation. The dynamic margin value is delegated to `DynamicFactorCalculator`, who have the responsability to load the given url and execute the logic to word/element counting, based on document/page type.

After the roundtrip, `BillCalculator` brings the amount of money to charge your user.

## Running some examples

`rake db:setup`

```ruby
BillCalculator.checkout Accunt.first.id

BillCalculator.checkout Accunt.last.id
```

## Tests

```bash
rspec spec
```

# Nice to

After while, I got it will nice to implement something like this, a configurable billing module:

```ruby
class FixedAccount < Account
  bill_as :fixed, url: 'https://example.com/', word: 'money', with: -> (v) { v * some_value_transformation }
end
```

Assuming the subscripion was based on Account inheritance and the resources will not cahange.

But, why I didn't build that? because I prefer the programmatic approch where I can load data from DB and execute the strategy without going to redeploy the app to change our clients billing plan.
