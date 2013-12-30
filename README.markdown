##  DataShift 

- [Features](#features)
- [Installation](#installation)
- [Active Record - Import/Export](#Active Record - Import/Export)
- [License](#license)

Provides tools to shift data between Excel/CSV files and Rails projects and Ruby applications

Import and export models fully with all associations.

Comprehensive Wiki here : **https://github.com/autotelik/datashift/wiki**

Specific command line tools and full Product loading for Spree E-Commerce 
now separate gem at [datashift_spree](https://github.com/autotelik/datashift_spree "Datashift Spree")


### Features

Import and Export ActiveRecord models direct to CSV or Excel/OpenOffice (.xls) (JRuby, 1.8.7, REE, 1.9.3)

You can select which associations to include and for import, set configurable defaults or over rides.

Create, parse and use Excel/OpenOffice (.xls) documents dynamically from Ruby (JRuby, 1.8.7, REE, 1.9.3)

Generate a sample template with headers only.

Export template and populate with model data 

Bulk import tools for Paperclip attachments.

Easily extendable Loader functionality to deal with non trivial import cases, such
as complex association lookups.

High level rake and thor command line tasks for import/export provided.

Specific loaders and command line tasks provided out the box for **Spree E-Commerce**, 
enabling import/export of Product data including creating Variants with different
 count on hands and all associations including Properties/Taxons/OptionTypes and Images.

Loaders can be configured via YAML with over ride values, default values and mandatory column settings.

Many example Spreadsheets/CSV files in spec/fixtures, fully documented with comments for each column.

## Installation

Add gem 'datashift' to your Gemfile/bundle or use ```gem install```

```ruby 
gem 'datashift' 
```

For Spree support also add :

```ruby 
gem 'datashift_spree'
```

To use :

    require 'datashift'

To use the Thor command line applications, pull in the tasks.

Generally the easiest way is to, create a high level .thor file in your Rails root directory

    e.g mysite.thor  

Edit the file and add the following to pull in the thor commands :

```ruby
    require 'thor'
    require 'datashift'

    DataShift::load_commands
```

To keep the availability to only development mode use

```ruby DataShift::load_commands if(Rails.env.development?) ```

To check the available tasks run

    bundle exec thor list datashift

To get usage information use thor help <command>, for example

    bundle exec thor help datashift:generate:excel

To use Excel OLE and MS Excel are NOT required.

Features a common Excel interface over both our own wrapper around Apache POI (JRuby) and spreadsheet gem (all main Rubies) 

This means you can switch seamlessly between the two libraries, and if required drop down to make use of advanced
features in the brilliant Apache POI libraries for anyone using JRuby.

Guards are provided, and used internally, for mixed Ruby setups. Can be used like :

    if(DataShift::Guards::jruby? )
        ..do something with Apache
    else
        ..do something with speadsheet
    end

## Active Record - Import/Export

Provides high level tasks for importing data via ActiveRecord models into a DB,
 from various sources, currently csv or .xls files (Excel/Open Office)

Please use thor list and thor help <xxx> to get latest command lines

    bundle exec thor datashift:import:csv model=BlogPost input=BlogPostImport.csv verbose=true 


Provides high level  tasks for exporting data to various sources, currently .xls files (Excel/Open Office)

    bundle exec thor datashift:export:excel model=BlogPost result=BlogExport.xls 

  
Import based on column headings with *Semi-Smart Name Lookup*

  On import, first a dictionary of all possible attributes and associations is created for the AR class.
  
  This enables lookup, of a user supplied name (column heading), managing white space, pluralisation etc .

  Example usage, load from a file or spreadsheet where the column names are only
  an approximation of the actual associations, so given 'Product Properties' heading,
  finds real association 'product_properties' to send or call on the AR object


Can import/export 'belongs_to, 'has_many' and 'has_one' associations, including assignment of multiple objects
via either multiple columns, or via a DSL for creating multiple entries in a single (column). 

The DSL can also be used to define which fields to lookup associations, and assign values to other fields.

See Wiki for more details on DSL syntax.

Supports inclusion of delegated attributes and normal instance methods as column headings.

The library can be easily extended with Loaders to deal with non trivial cases,
 for example when multiple lookups required to find right association.

Spree loaders are an example, these illustrate over riding processing for specific columns with
complicated lookup requirements. Spree is the prime Open Source e-commerce project for Rails, 
and the specific loaders and tasks support loading Spree Products, and associated data such as Variants,
OptionTypes, Properties and Images.

## Template Generation and Export

Template generation tasks can be used to export a model's definition as column headings to CSV or .xls.
These can be provided to developers or business users, as a template for data collection and then loading.

Export tasks can be used to export of a model's definition and any existing data stored in the database.

This data can be exported directly to CSV or Excel/OpenOffice spreadsheets.


## Example Spreadsheets
    
  A number of example Spreadsheets with headers and comments, can be found in the spec/fixtures directory.

  Extensive Spree samples - including .xls and csv versions for simple Products or complex Products with multiple
  taxons, variants properties etc - can be found in the spec/fixtures/spree subdirectory.

  Column headings contain comments with full descriptions and instructions on syntax. 


## Excel


  MS Excel itself does not need to be installed.

  Our proxy for Excel allows seamless switching between 'spreadsheet' gem and datashift's own JRuby wrapper over Apache POI.

  When using JRuby, Apache POI may offer advanced facilities not found in standard Ruby spreadsheet gem
  
  The required POI jars are already included.

  Excel/OpenOffice spreadsheets are heavily used in many sectors, so direct support makes it
  easier and quicker to migrate your client's data into a Rails/ActiveRecord project,
  without converting first to CSV or YAML.


### Associations

To perform a lookup for an associated model, the primary column(s) must be supplied, along with required select values for those columns.

A single association column can contain multiple name/value sets, in string form :

  column:lookup_key_1, lookup_key_2,...

So if our Project model has many Categories, we can supply a Category list, which is keyed on the column Category.reference with :

  |Categories|

  reference:category_001,category_002

During loading, a call to find_all_by_reference will be made, picking up the 2 categories with matching references,
 and our Project model will contain those two i.e project.categories = [category_002,category_003]


## TODO

  - Smart sorting of column processing order ....

  - Does not currently ensure mandatory columns (for valid?) processed first.

  - Look at implementing import/export API using something like https://github.com/ianwhite/orm_adapter 
    rather than active record, so we can support additional ORMs

    
## License

Copyright:: (c) Autotelik Media Ltd 2011

Author ::   Tom Statter

Date ::     Dec 2011

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.