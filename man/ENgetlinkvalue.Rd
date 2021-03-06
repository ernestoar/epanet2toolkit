% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/links.r
\name{ENgetlinkvalue}
\alias{ENgetlinkvalue}
\title{Retrieve parameter value for a link}
\usage{
ENgetlinkvalue(linkindex, paramcode)
}
\arguments{
\item{linkindex}{index of the link}

\item{paramcode}{requested parameter type either as name or number}
}
\value{
The parameter value of a specified link.
}
\description{
\code{ENgetlinkvalue} retrieves the value of a specific link parameter for a link.
}
\note{
Link indexes are consecutive integers starting from 1.
  Link parameter codes consist of the following constants:
  \tabular{lrl}{
  \code{EN_DIAMETER}		\tab 	0	\tab Diameter\cr
  \code{EN_LENGTH}		\tab	1	\tab Length\cr
  \code{EN_ROUGHNESS}	\tab	2	\tab Roughness coeff.\cr
  \code{EN_MINORLOSS}	\tab	3	\tab Minor loss coeff.\cr
  \code{EN_INITSTATUS}	\tab	4	\tab Initial link status (0 = closed, 1 = open)\cr
  \code{EN_INITSETTING}	\tab	5	\tab Initial pipe roughness\cr
							\tab 		\tab Initial pump speed\cr
							\tab 		\tab Initial valve setting\cr
  \code{EN_KBULK}		\tab 	6	\tab Bulk reaction coeff.\cr
  \code{EN_KWALL}		\tab	7	\tab Wall reaction coeff.\cr
  \code{EN_FLOW}			\tab    8	\tab Flow rate\cr
  \code{EN_VELOCITY}		\tab    9	\tab Flow velocity\cr
  \code{EN_HEADLOSS}	    \tab   10	\tab Head loss\cr
  \code{EN_STATUS}		\tab   11	\tab Actual link status (0 = closed, 1 = open)\cr
  \code{EN_SETTING}		\tab   12	\tab Pipe roughness\cr
							\tab  		\tab Actual pump speed\cr
							\tab  		\tab Actal valve setting\cr
  \code{EN_ENERGY}		\tab   13	\tab Energy expended in kwatts
  }
  Parameters 8 - 13 (\code{EN_FLOW} through \code{EN_ENERGY}) are computed values. The others
  are design parameters.

  Flow rate is positive if the direction of flow is from the designated start node of the link to
  its designated end node, and negative otherwise.

  Values are returned in units which depend on the units used for flow rate in the EPANET
  input file.
}
\examples{
# path to Net1.inp example file included with this package
inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
ENopen(inp, "Net1.rpt")
ENgetlinkvalue(1, "EN_DIAMETER")
ENgetlinkvalue(1, "EN_LENGTH")
ENgetlinkvalue(8, "EN_DIAMETER")
ENgetlinkvalue(8, "EN_LENGTH")
ENclose()
}
\seealso{
\code{ENgetlinkindex} \code{\link{ENgetflowunits}}
}
