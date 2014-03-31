name             'awscli'
maintainer       'Balanced'
maintainer_email 'mahmoud@balancedpayments.com'
license          'MIT'
description      'Installs/Configures awscli'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'balanced-apt', '~> 1.0.12'
depends 'python', '~> 1.4.4'
depends 'balanced-citadel', '~> 1.0.2'
