{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "823a1706",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "papermill": {
     "duration": 0.022896,
     "end_time": "2023-09-06T14:22:27.320268",
     "exception": false,
     "start_time": "2023-09-06T14:22:27.297372",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Analysis introductory\n",
    "Canada's housing market is a dynamic landscape shaped by a multitude of factors, from economic trends to population dynamics. In this analysis, we delve into a critical question facing potential investors and policymakers alike: Where should investments be directed within Canada's diverse regions? Our focus lies at the intersection of housing prices, population trends, and immigration patterns, seeking to uncover meaningful insights that can guide strategic decision-making.\n",
    "\n",
    "As regions across Canada experience varying levels of economic growth, demographic shifts, and policy developments, understanding the relationship between housing prices and factors such as population growth and immigration becomes paramount. Our analysis aims to not only identify these connections but also to shed light on potential investment opportunities that arise as a result."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "af65b1a9",
   "metadata": {
    "papermill": {
     "duration": 0.020486,
     "end_time": "2023-09-06T14:22:27.361906",
     "exception": false,
     "start_time": "2023-09-06T14:22:27.341420",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Data source\n",
    "* [New housing price index, monthly](https://open.canada.ca/data/en/dataset/324befd1-893b-42e6-bece-6d30af3dd9f1) - Housing price index month over month, which ever available, from January 1981 to July 2023. This data using base period for index is 201612=100, or the hosing price index in December 2016 is 100 as the base.\n",
    "\n",
    "* [Global population growth](https://data.worldbank.org/indicator/SP.POP.GROW?locations=CA) - this data has population growth for every country in the world year over year from 1961 to 2022.\n",
    "\n",
    "* [Permanent Residents by provinces/territory and immigration catergory](https://open.canada.ca/data/en/dataset/f7e5498e-0ad8-4417-85c9-9b8aff9b9eda) - showing the number of PR in different provinces/territory and immigration categories. Number has been rounded to prevent comparision and indentification. Value between 0 and 5 are shown as \"--\", and all other are rounded to nearest multiple of 5. Time frame from 2015 to 2022.\n",
    "\n",
    "* [Study permit holders - Monthly IRCC updates](https://open.canada.ca/data/en/dataset/90115b00-f9b8-49e8-afa3-b4cff8facaee) - Assuming this should match the number of international students who require to have a valid study permit to study in Canada, from 2000 to 2022.\n",
    "\n",
    "* [Work permit holders - Monthly IRCC updates](https://open.canada.ca/data/en/dataset/360024f2-17e9-4558-bfc1-3616485d65b9) - Number of people who are under Temporary Foreign Worker Program in Canada, from 2000 to 2022.\n",
    "\n",
    "* [Population in different province in Canada](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1710000901&cubeTimeFrame.startMonth=01&cubeTimeFrame.startYear=1981&cubeTimeFrame.endMonth=04&cubeTimeFrame.endYear=2023&referencePeriods=19810101%2C20230401) - This data gives us the population by provinces from 1981 to June 2023\n",
    "\n",
    "# Data licensing\n",
    "[Open Government License - Canada](https://open.canada.ca/en/open-government-licence-canada)\n",
    "\"You are encouraged to use the Information that is available under this licence with only a few conditions.\n",
    "\n",
    "**Using Information under this licence:**\n",
    "* Use of any Information indicates your acceptance of the terms below.\n",
    "* The Information Provider grants you a worldwide, royalty-free, perpetual, non-exclusive licence to use the Information, including for commercial purposes, subject to the terms below.\n",
    "\n",
    "**You are free to:**\n",
    "*Copy, modify, publish, translate, adapt, distribute or otherwise use the Information in any medium, mode or format for any lawful purpose.\n",
    "\n",
    "**You must, where you do any of the above:**\n",
    "* Acknowledge the source of the Information by including any attribution statement specified by the Information Provider(s) and, where possible, provide a link to this licence.\n",
    "* If the Information Provider does not provide a specific attribution statement, or if you are using Information from several information providers and multiple attributions are not practical for your product or application, you must use the following attribution statement:\n",
    "Contains information licensed under the Open Government Licence – Canada.\n",
    "\n",
    "The terms of this licence are important, and if you fail to comply with any of them, the rights granted to you under this licence, or any similar licence granted by the Information Provider, will end automatically.\n",
    "\n",
    "**Exemptions**\n",
    "This licence does not grant you any right to use:\n",
    "* Personal Information;\n",
    "third party rights the Information Provider is not authorized to license;\n",
    "the names, crests, logos, or other official symbols of the Information Provider; and\n",
    "* Information subject to other intellectual property rights, including patents, trade-marks and official marks.\n",
    "Non-endorsement\n",
    "* This licence does not grant you any right to use the Information in a way that suggests any official status or that the Information Provider endorses you or your use of the Information.\n",
    "\n",
    "**No Warranty**\n",
    "The Information is licensed “as is”, and the Information Provider excludes all representations, warranties, obligations, and liabilities, whether express or implied, to the maximum extent permitted by law.\n",
    "\n",
    "The Information Provider is not liable for any errors or omissions in the Information, and will not under any circumstances be liable for any direct, indirect, special, incidental, consequential, or other loss, injury or damage caused by its use or otherwise arising in connection with this licence or the Information, even if specifically advised of the possibility of such loss, injury or damage.\n",
    "\n",
    "**Governing Law**\n",
    "This licence is governed by the laws of the province of Ontario and the applicable laws of Canada.\n",
    "\n",
    "Legal proceedings related to this licence may only be brought in the courts of Ontario or the Federal Court of Canada.\n",
    "\n",
    "**Definitions**\n",
    "In this licence, the terms below have the following meanings:\n",
    "\n",
    "\"Information\"\n",
    "means information resources protected by copyright or other information that is offered for use under the terms of this licence.\n",
    "\"Information Provider\"\n",
    "means His Majesty the King in right of Canada.\n",
    "“Personal Information”\n",
    "means “personal information” as defined in section 3 of the Privacy Act, R.S.C. 1985, c. P-21.\n",
    "\"You\"\n",
    "means the natural or legal person, or body of persons corporate or incorporate, acquiring rights under this licence.\n",
    "\n",
    "**Versioning**\n",
    "This is version 2.0 of the Open Government Licence – Canada. The Information Provider may make changes to the terms of this licence from time to time and issue a new version of the licence. Your use of the Information will be governed by the terms of the licence in force as of the date you accessed the information.\"\n",
    "\n",
    "[Open Government License Consultation Report](https://open.canada.ca/en/open-government-licence-consultation-report)\n",
    "\n",
    "# Limitations\n",
    "**Data has been modified** to avoid comparison and identification in the number of Permanent residents, value in this dataset also got modified if it's small (0 to 5). However, since the difference is small, but it is a good proxy for the analysis.\n",
    "\n",
    "**Various time frame** in different dataset, so we will have to limit the analysis from 1981 to 2022.\n",
    "\n",
    "# Data processing\n",
    "## Load require packages"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "78638361",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:27.409413Z",
     "iopub.status.busy": "2023-09-06T14:22:27.406031Z",
     "iopub.status.idle": "2023-09-06T14:22:28.725163Z",
     "shell.execute_reply": "2023-09-06T14:22:28.722972Z"
    },
    "papermill": {
     "duration": 1.346483,
     "end_time": "2023-09-06T14:22:28.728762",
     "exception": false,
     "start_time": "2023-09-06T14:22:27.382279",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.2     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.2     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.2     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.1     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n",
      "\n",
      "Attaching package: ‘janitor’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    chisq.test, fisher.test\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(tidyverse) ## data cleaning and plotting\n",
    "library(readr) ## importing csv\n",
    "library(lubridate) ## formating date\n",
    "library(janitor) ## data cleaning\n",
    "library(readxl) ## read excel"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ec075b21",
   "metadata": {
    "papermill": {
     "duration": 0.02072,
     "end_time": "2023-09-06T14:22:28.770473",
     "exception": false,
     "start_time": "2023-09-06T14:22:28.749753",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Canada population"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "73c6596b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:28.847989Z",
     "iopub.status.busy": "2023-09-06T14:22:28.814114Z",
     "iopub.status.idle": "2023-09-06T14:22:29.372730Z",
     "shell.execute_reply": "2023-09-06T14:22:29.370642Z"
    },
    "papermill": {
     "duration": 0.58432,
     "end_time": "2023-09-06T14:22:29.375531",
     "exception": false,
     "start_time": "2023-09-06T14:22:28.791211",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m3895\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m14\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m (6): REF_DATE, GEO, DGUID, UOM, SCALAR_FACTOR, VECTOR\n",
      "\u001b[32mdbl\u001b[39m (5): UOM_ID, SCALAR_ID, COORDINATE, VALUE, DECIMALS\n",
      "\u001b[33mlgl\u001b[39m (3): STATUS, SYMBOL, TERMINATED\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 3895 × 14</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>REF_DATE</th><th scope=col>GEO</th><th scope=col>DGUID</th><th scope=col>UOM</th><th scope=col>UOM_ID</th><th scope=col>SCALAR_FACTOR</th><th scope=col>SCALAR_ID</th><th scope=col>VECTOR</th><th scope=col>COORDINATE</th><th scope=col>VALUE</th><th scope=col>STATUS</th><th scope=col>SYMBOL</th><th scope=col>TERMINATED</th><th scope=col>DECIMALS</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Jan-46</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12188000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-46</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12241000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-46</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12316000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Oct-46</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12393000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-47</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12450000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-47</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12507000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-47</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12576000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Oct-47</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12646000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-48</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12710000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-48</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12773000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-48</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12852000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Oct-48</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12930000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-49</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>12998000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-49</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13399000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-49</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13475000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Oct-49</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13548000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-50</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13607000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-50</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13663000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-50</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13737000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Oct-50</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13807000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-51</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13870000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-51</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>13937000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td>1</td><td>14050000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>Newfoundland_and_Labrador</td><td>2016A000210   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v2 </td><td>2</td><td>  362000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>Prince_Edward_Island     </td><td>2016A000211   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v8 </td><td>3</td><td>   99000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>Nova_Scotia              </td><td>2016A000212   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v9 </td><td>4</td><td>  643000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>New_Brunswick            </td><td>2016A000213   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v10</td><td>5</td><td>  517000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>Quebec                   </td><td>2016A000224   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v11</td><td>6</td><td> 4066000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>Ontario                  </td><td>2016A000235   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v12</td><td>7</td><td> 4615000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jul-51</td><td>Manitoba                 </td><td>2016A000246   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v13</td><td>8</td><td>  778000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>Oct-22</td><td>Northwest_Territories    </td><td>2016A000261   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v6 </td><td>14</td><td>   45602</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Oct-22</td><td>Nunavut                  </td><td>2016A000262   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v7 </td><td>15</td><td>   40586</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td> 1</td><td>39566248</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Newfoundland_and_Labrador</td><td>2016A000210   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v2 </td><td> 2</td><td>  531948</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Prince_Edward_Island     </td><td>2016A000211   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v8 </td><td> 3</td><td>  173954</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Nova_Scotia              </td><td>2016A000212   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v9 </td><td> 4</td><td> 1037782</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>New_Brunswick            </td><td>2016A000213   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v10</td><td> 5</td><td>  825474</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Quebec                   </td><td>2016A000224   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v11</td><td> 6</td><td> 8787554</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Ontario                  </td><td>2016A000235   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v12</td><td> 7</td><td>15386407</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Manitoba                 </td><td>2016A000246   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v13</td><td> 8</td><td> 1431792</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Saskatchewan             </td><td>2016A000247   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v14</td><td> 9</td><td> 1214618</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Alberta                  </td><td>2016A000248   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v15</td><td>10</td><td> 4647178</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>British_Columbia         </td><td>2016A000259   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v3 </td><td>11</td><td> 5399118</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Yukon                    </td><td>2016A000260   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v4 </td><td>12</td><td>   44238</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Northwest_Territories    </td><td>2016A000261   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v6 </td><td>14</td><td>   45493</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Jan-23</td><td>Nunavut                  </td><td>2016A000262   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v7 </td><td>15</td><td>   40692</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Canada                   </td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1 </td><td> 1</td><td>39858480</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Newfoundland_and_Labrador</td><td>2016A000210   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v2 </td><td> 2</td><td>  533710</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Prince_Edward_Island     </td><td>2016A000211   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v8 </td><td> 3</td><td>  176113</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Nova_Scotia              </td><td>2016A000212   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v9 </td><td> 4</td><td> 1047232</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>New_Brunswick            </td><td>2016A000213   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v10</td><td> 5</td><td>  831618</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Quebec                   </td><td>2016A000224   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v11</td><td> 6</td><td> 8831257</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Ontario                  </td><td>2016A000235   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v12</td><td> 7</td><td>15500632</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Manitoba                 </td><td>2016A000246   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v13</td><td> 8</td><td> 1444190</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Saskatchewan             </td><td>2016A000247   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v14</td><td> 9</td><td> 1221439</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Alberta                  </td><td>2016A000248   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v15</td><td>10</td><td> 4703772</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>British_Columbia         </td><td>2016A000259   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v3 </td><td>11</td><td> 5437722</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Yukon                    </td><td>2016A000260   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v4 </td><td>12</td><td>   44412</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Northwest_Territories    </td><td>2016A000261   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v6 </td><td>14</td><td>   45668</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "\t<tr><td>Apr-23</td><td>Nunavut                  </td><td>2016A000262   </td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v7 </td><td>15</td><td>   40715</td><td>NA</td><td>NA</td><td>NA</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 3895 × 14\n",
       "\\begin{tabular}{llllllllllllll}\n",
       " REF\\_DATE & GEO & DGUID & UOM & UOM\\_ID & SCALAR\\_FACTOR & SCALAR\\_ID & VECTOR & COORDINATE & VALUE & STATUS & SYMBOL & TERMINATED & DECIMALS\\\\\n",
       " <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <lgl> & <lgl> & <lgl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Jan-46 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12188000 & NA & NA & NA & 0\\\\\n",
       "\t Apr-46 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12241000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-46 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12316000 & NA & NA & NA & 0\\\\\n",
       "\t Oct-46 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12393000 & NA & NA & NA & 0\\\\\n",
       "\t Jan-47 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12450000 & NA & NA & NA & 0\\\\\n",
       "\t Apr-47 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12507000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-47 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12576000 & NA & NA & NA & 0\\\\\n",
       "\t Oct-47 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12646000 & NA & NA & NA & 0\\\\\n",
       "\t Jan-48 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12710000 & NA & NA & NA & 0\\\\\n",
       "\t Apr-48 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12773000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-48 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12852000 & NA & NA & NA & 0\\\\\n",
       "\t Oct-48 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12930000 & NA & NA & NA & 0\\\\\n",
       "\t Jan-49 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 12998000 & NA & NA & NA & 0\\\\\n",
       "\t Apr-49 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13399000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-49 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13475000 & NA & NA & NA & 0\\\\\n",
       "\t Oct-49 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13548000 & NA & NA & NA & 0\\\\\n",
       "\t Jan-50 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13607000 & NA & NA & NA & 0\\\\\n",
       "\t Apr-50 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13663000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-50 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13737000 & NA & NA & NA & 0\\\\\n",
       "\t Oct-50 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13807000 & NA & NA & NA & 0\\\\\n",
       "\t Jan-51 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13870000 & NA & NA & NA & 0\\\\\n",
       "\t Apr-51 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 13937000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  & 1 & 14050000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & Newfoundland\\_and\\_Labrador & 2016A000210    & Persons & 249 & units & 0 & v2  & 2 &   362000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & Prince\\_Edward\\_Island      & 2016A000211    & Persons & 249 & units & 0 & v8  & 3 &    99000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & Nova\\_Scotia               & 2016A000212    & Persons & 249 & units & 0 & v9  & 4 &   643000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & New\\_Brunswick             & 2016A000213    & Persons & 249 & units & 0 & v10 & 5 &   517000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & Quebec                    & 2016A000224    & Persons & 249 & units & 0 & v11 & 6 &  4066000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & Ontario                   & 2016A000235    & Persons & 249 & units & 0 & v12 & 7 &  4615000 & NA & NA & NA & 0\\\\\n",
       "\t Jul-51 & Manitoba                  & 2016A000246    & Persons & 249 & units & 0 & v13 & 8 &   778000 & NA & NA & NA & 0\\\\\n",
       "\t ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮\\\\\n",
       "\t Oct-22 & Northwest\\_Territories     & 2016A000261    & Persons & 249 & units & 0 & v6  & 14 &    45602 & NA & NA & NA & 0\\\\\n",
       "\t Oct-22 & Nunavut                   & 2016A000262    & Persons & 249 & units & 0 & v7  & 15 &    40586 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  &  1 & 39566248 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Newfoundland\\_and\\_Labrador & 2016A000210    & Persons & 249 & units & 0 & v2  &  2 &   531948 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Prince\\_Edward\\_Island      & 2016A000211    & Persons & 249 & units & 0 & v8  &  3 &   173954 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Nova\\_Scotia               & 2016A000212    & Persons & 249 & units & 0 & v9  &  4 &  1037782 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & New\\_Brunswick             & 2016A000213    & Persons & 249 & units & 0 & v10 &  5 &   825474 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Quebec                    & 2016A000224    & Persons & 249 & units & 0 & v11 &  6 &  8787554 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Ontario                   & 2016A000235    & Persons & 249 & units & 0 & v12 &  7 & 15386407 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Manitoba                  & 2016A000246    & Persons & 249 & units & 0 & v13 &  8 &  1431792 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Saskatchewan              & 2016A000247    & Persons & 249 & units & 0 & v14 &  9 &  1214618 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Alberta                   & 2016A000248    & Persons & 249 & units & 0 & v15 & 10 &  4647178 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & British\\_Columbia          & 2016A000259    & Persons & 249 & units & 0 & v3  & 11 &  5399118 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Yukon                     & 2016A000260    & Persons & 249 & units & 0 & v4  & 12 &    44238 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Northwest\\_Territories     & 2016A000261    & Persons & 249 & units & 0 & v6  & 14 &    45493 & NA & NA & NA & 0\\\\\n",
       "\t Jan-23 & Nunavut                   & 2016A000262    & Persons & 249 & units & 0 & v7  & 15 &    40692 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Canada                    & 2016A000011124 & Persons & 249 & units & 0 & v1  &  1 & 39858480 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Newfoundland\\_and\\_Labrador & 2016A000210    & Persons & 249 & units & 0 & v2  &  2 &   533710 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Prince\\_Edward\\_Island      & 2016A000211    & Persons & 249 & units & 0 & v8  &  3 &   176113 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Nova\\_Scotia               & 2016A000212    & Persons & 249 & units & 0 & v9  &  4 &  1047232 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & New\\_Brunswick             & 2016A000213    & Persons & 249 & units & 0 & v10 &  5 &   831618 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Quebec                    & 2016A000224    & Persons & 249 & units & 0 & v11 &  6 &  8831257 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Ontario                   & 2016A000235    & Persons & 249 & units & 0 & v12 &  7 & 15500632 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Manitoba                  & 2016A000246    & Persons & 249 & units & 0 & v13 &  8 &  1444190 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Saskatchewan              & 2016A000247    & Persons & 249 & units & 0 & v14 &  9 &  1221439 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Alberta                   & 2016A000248    & Persons & 249 & units & 0 & v15 & 10 &  4703772 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & British\\_Columbia          & 2016A000259    & Persons & 249 & units & 0 & v3  & 11 &  5437722 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Yukon                     & 2016A000260    & Persons & 249 & units & 0 & v4  & 12 &    44412 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Northwest\\_Territories     & 2016A000261    & Persons & 249 & units & 0 & v6  & 14 &    45668 & NA & NA & NA & 0\\\\\n",
       "\t Apr-23 & Nunavut                   & 2016A000262    & Persons & 249 & units & 0 & v7  & 15 &    40715 & NA & NA & NA & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 3895 × 14\n",
       "\n",
       "| REF_DATE &lt;chr&gt; | GEO &lt;chr&gt; | DGUID &lt;chr&gt; | UOM &lt;chr&gt; | UOM_ID &lt;dbl&gt; | SCALAR_FACTOR &lt;chr&gt; | SCALAR_ID &lt;dbl&gt; | VECTOR &lt;chr&gt; | COORDINATE &lt;dbl&gt; | VALUE &lt;dbl&gt; | STATUS &lt;lgl&gt; | SYMBOL &lt;lgl&gt; | TERMINATED &lt;lgl&gt; | DECIMALS &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| Jan-46 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12188000 | NA | NA | NA | 0 |\n",
       "| Apr-46 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12241000 | NA | NA | NA | 0 |\n",
       "| Jul-46 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12316000 | NA | NA | NA | 0 |\n",
       "| Oct-46 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12393000 | NA | NA | NA | 0 |\n",
       "| Jan-47 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12450000 | NA | NA | NA | 0 |\n",
       "| Apr-47 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12507000 | NA | NA | NA | 0 |\n",
       "| Jul-47 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12576000 | NA | NA | NA | 0 |\n",
       "| Oct-47 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12646000 | NA | NA | NA | 0 |\n",
       "| Jan-48 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12710000 | NA | NA | NA | 0 |\n",
       "| Apr-48 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12773000 | NA | NA | NA | 0 |\n",
       "| Jul-48 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12852000 | NA | NA | NA | 0 |\n",
       "| Oct-48 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12930000 | NA | NA | NA | 0 |\n",
       "| Jan-49 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 12998000 | NA | NA | NA | 0 |\n",
       "| Apr-49 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13399000 | NA | NA | NA | 0 |\n",
       "| Jul-49 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13475000 | NA | NA | NA | 0 |\n",
       "| Oct-49 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13548000 | NA | NA | NA | 0 |\n",
       "| Jan-50 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13607000 | NA | NA | NA | 0 |\n",
       "| Apr-50 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13663000 | NA | NA | NA | 0 |\n",
       "| Jul-50 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13737000 | NA | NA | NA | 0 |\n",
       "| Oct-50 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13807000 | NA | NA | NA | 0 |\n",
       "| Jan-51 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13870000 | NA | NA | NA | 0 |\n",
       "| Apr-51 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 13937000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  | 1 | 14050000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | Newfoundland_and_Labrador | 2016A000210    | Persons | 249 | units | 0 | v2  | 2 |   362000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | Prince_Edward_Island      | 2016A000211    | Persons | 249 | units | 0 | v8  | 3 |    99000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | Nova_Scotia               | 2016A000212    | Persons | 249 | units | 0 | v9  | 4 |   643000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | New_Brunswick             | 2016A000213    | Persons | 249 | units | 0 | v10 | 5 |   517000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | Quebec                    | 2016A000224    | Persons | 249 | units | 0 | v11 | 6 |  4066000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | Ontario                   | 2016A000235    | Persons | 249 | units | 0 | v12 | 7 |  4615000 | NA | NA | NA | 0 |\n",
       "| Jul-51 | Manitoba                  | 2016A000246    | Persons | 249 | units | 0 | v13 | 8 |   778000 | NA | NA | NA | 0 |\n",
       "| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |\n",
       "| Oct-22 | Northwest_Territories     | 2016A000261    | Persons | 249 | units | 0 | v6  | 14 |    45602 | NA | NA | NA | 0 |\n",
       "| Oct-22 | Nunavut                   | 2016A000262    | Persons | 249 | units | 0 | v7  | 15 |    40586 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  |  1 | 39566248 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Newfoundland_and_Labrador | 2016A000210    | Persons | 249 | units | 0 | v2  |  2 |   531948 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Prince_Edward_Island      | 2016A000211    | Persons | 249 | units | 0 | v8  |  3 |   173954 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Nova_Scotia               | 2016A000212    | Persons | 249 | units | 0 | v9  |  4 |  1037782 | NA | NA | NA | 0 |\n",
       "| Jan-23 | New_Brunswick             | 2016A000213    | Persons | 249 | units | 0 | v10 |  5 |   825474 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Quebec                    | 2016A000224    | Persons | 249 | units | 0 | v11 |  6 |  8787554 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Ontario                   | 2016A000235    | Persons | 249 | units | 0 | v12 |  7 | 15386407 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Manitoba                  | 2016A000246    | Persons | 249 | units | 0 | v13 |  8 |  1431792 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Saskatchewan              | 2016A000247    | Persons | 249 | units | 0 | v14 |  9 |  1214618 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Alberta                   | 2016A000248    | Persons | 249 | units | 0 | v15 | 10 |  4647178 | NA | NA | NA | 0 |\n",
       "| Jan-23 | British_Columbia          | 2016A000259    | Persons | 249 | units | 0 | v3  | 11 |  5399118 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Yukon                     | 2016A000260    | Persons | 249 | units | 0 | v4  | 12 |    44238 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Northwest_Territories     | 2016A000261    | Persons | 249 | units | 0 | v6  | 14 |    45493 | NA | NA | NA | 0 |\n",
       "| Jan-23 | Nunavut                   | 2016A000262    | Persons | 249 | units | 0 | v7  | 15 |    40692 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Canada                    | 2016A000011124 | Persons | 249 | units | 0 | v1  |  1 | 39858480 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Newfoundland_and_Labrador | 2016A000210    | Persons | 249 | units | 0 | v2  |  2 |   533710 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Prince_Edward_Island      | 2016A000211    | Persons | 249 | units | 0 | v8  |  3 |   176113 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Nova_Scotia               | 2016A000212    | Persons | 249 | units | 0 | v9  |  4 |  1047232 | NA | NA | NA | 0 |\n",
       "| Apr-23 | New_Brunswick             | 2016A000213    | Persons | 249 | units | 0 | v10 |  5 |   831618 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Quebec                    | 2016A000224    | Persons | 249 | units | 0 | v11 |  6 |  8831257 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Ontario                   | 2016A000235    | Persons | 249 | units | 0 | v12 |  7 | 15500632 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Manitoba                  | 2016A000246    | Persons | 249 | units | 0 | v13 |  8 |  1444190 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Saskatchewan              | 2016A000247    | Persons | 249 | units | 0 | v14 |  9 |  1221439 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Alberta                   | 2016A000248    | Persons | 249 | units | 0 | v15 | 10 |  4703772 | NA | NA | NA | 0 |\n",
       "| Apr-23 | British_Columbia          | 2016A000259    | Persons | 249 | units | 0 | v3  | 11 |  5437722 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Yukon                     | 2016A000260    | Persons | 249 | units | 0 | v4  | 12 |    44412 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Northwest_Territories     | 2016A000261    | Persons | 249 | units | 0 | v6  | 14 |    45668 | NA | NA | NA | 0 |\n",
       "| Apr-23 | Nunavut                   | 2016A000262    | Persons | 249 | units | 0 | v7  | 15 |    40715 | NA | NA | NA | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "     REF_DATE GEO                       DGUID          UOM     UOM_ID\n",
       "1    Jan-46   Canada                    2016A000011124 Persons 249   \n",
       "2    Apr-46   Canada                    2016A000011124 Persons 249   \n",
       "3    Jul-46   Canada                    2016A000011124 Persons 249   \n",
       "4    Oct-46   Canada                    2016A000011124 Persons 249   \n",
       "5    Jan-47   Canada                    2016A000011124 Persons 249   \n",
       "6    Apr-47   Canada                    2016A000011124 Persons 249   \n",
       "7    Jul-47   Canada                    2016A000011124 Persons 249   \n",
       "8    Oct-47   Canada                    2016A000011124 Persons 249   \n",
       "9    Jan-48   Canada                    2016A000011124 Persons 249   \n",
       "10   Apr-48   Canada                    2016A000011124 Persons 249   \n",
       "11   Jul-48   Canada                    2016A000011124 Persons 249   \n",
       "12   Oct-48   Canada                    2016A000011124 Persons 249   \n",
       "13   Jan-49   Canada                    2016A000011124 Persons 249   \n",
       "14   Apr-49   Canada                    2016A000011124 Persons 249   \n",
       "15   Jul-49   Canada                    2016A000011124 Persons 249   \n",
       "16   Oct-49   Canada                    2016A000011124 Persons 249   \n",
       "17   Jan-50   Canada                    2016A000011124 Persons 249   \n",
       "18   Apr-50   Canada                    2016A000011124 Persons 249   \n",
       "19   Jul-50   Canada                    2016A000011124 Persons 249   \n",
       "20   Oct-50   Canada                    2016A000011124 Persons 249   \n",
       "21   Jan-51   Canada                    2016A000011124 Persons 249   \n",
       "22   Apr-51   Canada                    2016A000011124 Persons 249   \n",
       "23   Jul-51   Canada                    2016A000011124 Persons 249   \n",
       "24   Jul-51   Newfoundland_and_Labrador 2016A000210    Persons 249   \n",
       "25   Jul-51   Prince_Edward_Island      2016A000211    Persons 249   \n",
       "26   Jul-51   Nova_Scotia               2016A000212    Persons 249   \n",
       "27   Jul-51   New_Brunswick             2016A000213    Persons 249   \n",
       "28   Jul-51   Quebec                    2016A000224    Persons 249   \n",
       "29   Jul-51   Ontario                   2016A000235    Persons 249   \n",
       "30   Jul-51   Manitoba                  2016A000246    Persons 249   \n",
       "⋮    ⋮        ⋮                         ⋮              ⋮       ⋮     \n",
       "3866 Oct-22   Northwest_Territories     2016A000261    Persons 249   \n",
       "3867 Oct-22   Nunavut                   2016A000262    Persons 249   \n",
       "3868 Jan-23   Canada                    2016A000011124 Persons 249   \n",
       "3869 Jan-23   Newfoundland_and_Labrador 2016A000210    Persons 249   \n",
       "3870 Jan-23   Prince_Edward_Island      2016A000211    Persons 249   \n",
       "3871 Jan-23   Nova_Scotia               2016A000212    Persons 249   \n",
       "3872 Jan-23   New_Brunswick             2016A000213    Persons 249   \n",
       "3873 Jan-23   Quebec                    2016A000224    Persons 249   \n",
       "3874 Jan-23   Ontario                   2016A000235    Persons 249   \n",
       "3875 Jan-23   Manitoba                  2016A000246    Persons 249   \n",
       "3876 Jan-23   Saskatchewan              2016A000247    Persons 249   \n",
       "3877 Jan-23   Alberta                   2016A000248    Persons 249   \n",
       "3878 Jan-23   British_Columbia          2016A000259    Persons 249   \n",
       "3879 Jan-23   Yukon                     2016A000260    Persons 249   \n",
       "3880 Jan-23   Northwest_Territories     2016A000261    Persons 249   \n",
       "3881 Jan-23   Nunavut                   2016A000262    Persons 249   \n",
       "3882 Apr-23   Canada                    2016A000011124 Persons 249   \n",
       "3883 Apr-23   Newfoundland_and_Labrador 2016A000210    Persons 249   \n",
       "3884 Apr-23   Prince_Edward_Island      2016A000211    Persons 249   \n",
       "3885 Apr-23   Nova_Scotia               2016A000212    Persons 249   \n",
       "3886 Apr-23   New_Brunswick             2016A000213    Persons 249   \n",
       "3887 Apr-23   Quebec                    2016A000224    Persons 249   \n",
       "3888 Apr-23   Ontario                   2016A000235    Persons 249   \n",
       "3889 Apr-23   Manitoba                  2016A000246    Persons 249   \n",
       "3890 Apr-23   Saskatchewan              2016A000247    Persons 249   \n",
       "3891 Apr-23   Alberta                   2016A000248    Persons 249   \n",
       "3892 Apr-23   British_Columbia          2016A000259    Persons 249   \n",
       "3893 Apr-23   Yukon                     2016A000260    Persons 249   \n",
       "3894 Apr-23   Northwest_Territories     2016A000261    Persons 249   \n",
       "3895 Apr-23   Nunavut                   2016A000262    Persons 249   \n",
       "     SCALAR_FACTOR SCALAR_ID VECTOR COORDINATE VALUE    STATUS SYMBOL\n",
       "1    units         0         v1     1          12188000 NA     NA    \n",
       "2    units         0         v1     1          12241000 NA     NA    \n",
       "3    units         0         v1     1          12316000 NA     NA    \n",
       "4    units         0         v1     1          12393000 NA     NA    \n",
       "5    units         0         v1     1          12450000 NA     NA    \n",
       "6    units         0         v1     1          12507000 NA     NA    \n",
       "7    units         0         v1     1          12576000 NA     NA    \n",
       "8    units         0         v1     1          12646000 NA     NA    \n",
       "9    units         0         v1     1          12710000 NA     NA    \n",
       "10   units         0         v1     1          12773000 NA     NA    \n",
       "11   units         0         v1     1          12852000 NA     NA    \n",
       "12   units         0         v1     1          12930000 NA     NA    \n",
       "13   units         0         v1     1          12998000 NA     NA    \n",
       "14   units         0         v1     1          13399000 NA     NA    \n",
       "15   units         0         v1     1          13475000 NA     NA    \n",
       "16   units         0         v1     1          13548000 NA     NA    \n",
       "17   units         0         v1     1          13607000 NA     NA    \n",
       "18   units         0         v1     1          13663000 NA     NA    \n",
       "19   units         0         v1     1          13737000 NA     NA    \n",
       "20   units         0         v1     1          13807000 NA     NA    \n",
       "21   units         0         v1     1          13870000 NA     NA    \n",
       "22   units         0         v1     1          13937000 NA     NA    \n",
       "23   units         0         v1     1          14050000 NA     NA    \n",
       "24   units         0         v2     2            362000 NA     NA    \n",
       "25   units         0         v8     3             99000 NA     NA    \n",
       "26   units         0         v9     4            643000 NA     NA    \n",
       "27   units         0         v10    5            517000 NA     NA    \n",
       "28   units         0         v11    6           4066000 NA     NA    \n",
       "29   units         0         v12    7           4615000 NA     NA    \n",
       "30   units         0         v13    8            778000 NA     NA    \n",
       "⋮    ⋮             ⋮         ⋮      ⋮          ⋮        ⋮      ⋮     \n",
       "3866 units         0         v6     14            45602 NA     NA    \n",
       "3867 units         0         v7     15            40586 NA     NA    \n",
       "3868 units         0         v1      1         39566248 NA     NA    \n",
       "3869 units         0         v2      2           531948 NA     NA    \n",
       "3870 units         0         v8      3           173954 NA     NA    \n",
       "3871 units         0         v9      4          1037782 NA     NA    \n",
       "3872 units         0         v10     5           825474 NA     NA    \n",
       "3873 units         0         v11     6          8787554 NA     NA    \n",
       "3874 units         0         v12     7         15386407 NA     NA    \n",
       "3875 units         0         v13     8          1431792 NA     NA    \n",
       "3876 units         0         v14     9          1214618 NA     NA    \n",
       "3877 units         0         v15    10          4647178 NA     NA    \n",
       "3878 units         0         v3     11          5399118 NA     NA    \n",
       "3879 units         0         v4     12            44238 NA     NA    \n",
       "3880 units         0         v6     14            45493 NA     NA    \n",
       "3881 units         0         v7     15            40692 NA     NA    \n",
       "3882 units         0         v1      1         39858480 NA     NA    \n",
       "3883 units         0         v2      2           533710 NA     NA    \n",
       "3884 units         0         v8      3           176113 NA     NA    \n",
       "3885 units         0         v9      4          1047232 NA     NA    \n",
       "3886 units         0         v10     5           831618 NA     NA    \n",
       "3887 units         0         v11     6          8831257 NA     NA    \n",
       "3888 units         0         v12     7         15500632 NA     NA    \n",
       "3889 units         0         v13     8          1444190 NA     NA    \n",
       "3890 units         0         v14     9          1221439 NA     NA    \n",
       "3891 units         0         v15    10          4703772 NA     NA    \n",
       "3892 units         0         v3     11          5437722 NA     NA    \n",
       "3893 units         0         v4     12            44412 NA     NA    \n",
       "3894 units         0         v6     14            45668 NA     NA    \n",
       "3895 units         0         v7     15            40715 NA     NA    \n",
       "     TERMINATED DECIMALS\n",
       "1    NA         0       \n",
       "2    NA         0       \n",
       "3    NA         0       \n",
       "4    NA         0       \n",
       "5    NA         0       \n",
       "6    NA         0       \n",
       "7    NA         0       \n",
       "8    NA         0       \n",
       "9    NA         0       \n",
       "10   NA         0       \n",
       "11   NA         0       \n",
       "12   NA         0       \n",
       "13   NA         0       \n",
       "14   NA         0       \n",
       "15   NA         0       \n",
       "16   NA         0       \n",
       "17   NA         0       \n",
       "18   NA         0       \n",
       "19   NA         0       \n",
       "20   NA         0       \n",
       "21   NA         0       \n",
       "22   NA         0       \n",
       "23   NA         0       \n",
       "24   NA         0       \n",
       "25   NA         0       \n",
       "26   NA         0       \n",
       "27   NA         0       \n",
       "28   NA         0       \n",
       "29   NA         0       \n",
       "30   NA         0       \n",
       "⋮    ⋮          ⋮       \n",
       "3866 NA         0       \n",
       "3867 NA         0       \n",
       "3868 NA         0       \n",
       "3869 NA         0       \n",
       "3870 NA         0       \n",
       "3871 NA         0       \n",
       "3872 NA         0       \n",
       "3873 NA         0       \n",
       "3874 NA         0       \n",
       "3875 NA         0       \n",
       "3876 NA         0       \n",
       "3877 NA         0       \n",
       "3878 NA         0       \n",
       "3879 NA         0       \n",
       "3880 NA         0       \n",
       "3881 NA         0       \n",
       "3882 NA         0       \n",
       "3883 NA         0       \n",
       "3884 NA         0       \n",
       "3885 NA         0       \n",
       "3886 NA         0       \n",
       "3887 NA         0       \n",
       "3888 NA         0       \n",
       "3889 NA         0       \n",
       "3890 NA         0       \n",
       "3891 NA         0       \n",
       "3892 NA         0       \n",
       "3893 NA         0       \n",
       "3894 NA         0       \n",
       "3895 NA         0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 3,895\n",
      "Columns: 14\n",
      "$ REF_DATE      \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"Jan-46\", \"Apr-46\", \"Jul-46\", \"Oct-46\", \"Jan-47\", \"Apr-4…\n",
      "$ GEO           \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"Canada\", \"Canada\", \"Canada\", \"Canada\", \"Canada\", \"Canad…\n",
      "$ DGUID         \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"2016A000011124\", \"2016A000011124\", \"2016A000011124\", \"2…\n",
      "$ UOM           \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"Persons\", \"Persons\", \"Persons\", \"Persons\", \"Persons\", \"…\n",
      "$ UOM_ID        \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 2…\n",
      "$ SCALAR_FACTOR \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"units\", \"units\", \"units\", \"units\", \"units\", \"units\", \"u…\n",
      "$ SCALAR_ID     \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…\n",
      "$ VECTOR        \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"v1\", \"v1\", \"v1\", \"v1\", \"v1\", \"v1\", \"v1\", \"v1\", \"v1\", \"v…\n",
      "$ COORDINATE    \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…\n",
      "$ VALUE         \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 12188000, 12241000, 12316000, 12393000, 12450000, 125070…\n",
      "$ STATUS        \u001b[3m\u001b[90m<lgl>\u001b[39m\u001b[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …\n",
      "$ SYMBOL        \u001b[3m\u001b[90m<lgl>\u001b[39m\u001b[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …\n",
      "$ TERMINATED    \u001b[3m\u001b[90m<lgl>\u001b[39m\u001b[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …\n",
      "$ DECIMALS      \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…\n"
     ]
    }
   ],
   "source": [
    "ca_population <- read_csv(\"/kaggle/input/canada-population-vs-housing-price/ca_population.csv\")\n",
    "View(ca_population)\n",
    "glimpse(ca_population)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "915651d4",
   "metadata": {
    "papermill": {
     "duration": 0.022825,
     "end_time": "2023-09-06T14:22:29.421373",
     "exception": false,
     "start_time": "2023-09-06T14:22:29.398548",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Global polulation growth"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "a0d25479",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:29.470863Z",
     "iopub.status.busy": "2023-09-06T14:22:29.469127Z",
     "iopub.status.idle": "2023-09-06T14:22:30.777568Z",
     "shell.execute_reply": "2023-09-06T14:22:30.775710Z"
    },
    "papermill": {
     "duration": 1.336018,
     "end_time": "2023-09-06T14:22:30.780073",
     "exception": false,
     "start_time": "2023-09-06T14:22:29.444055",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22mNew names:\n",
      "\u001b[36m•\u001b[39m `` -> `...3`\n",
      "\u001b[36m•\u001b[39m `` -> `...4`\n",
      "\u001b[36m•\u001b[39m `` -> `...5`\n",
      "\u001b[36m•\u001b[39m `` -> `...6`\n",
      "\u001b[36m•\u001b[39m `` -> `...7`\n",
      "\u001b[36m•\u001b[39m `` -> `...8`\n",
      "\u001b[36m•\u001b[39m `` -> `...9`\n",
      "\u001b[36m•\u001b[39m `` -> `...10`\n",
      "\u001b[36m•\u001b[39m `` -> `...11`\n",
      "\u001b[36m•\u001b[39m `` -> `...12`\n",
      "\u001b[36m•\u001b[39m `` -> `...13`\n",
      "\u001b[36m•\u001b[39m `` -> `...14`\n",
      "\u001b[36m•\u001b[39m `` -> `...15`\n",
      "\u001b[36m•\u001b[39m `` -> `...16`\n",
      "\u001b[36m•\u001b[39m `` -> `...17`\n",
      "\u001b[36m•\u001b[39m `` -> `...18`\n",
      "\u001b[36m•\u001b[39m `` -> `...19`\n",
      "\u001b[36m•\u001b[39m `` -> `...20`\n",
      "\u001b[36m•\u001b[39m `` -> `...21`\n",
      "\u001b[36m•\u001b[39m `` -> `...22`\n",
      "\u001b[36m•\u001b[39m `` -> `...23`\n",
      "\u001b[36m•\u001b[39m `` -> `...24`\n",
      "\u001b[36m•\u001b[39m `` -> `...25`\n",
      "\u001b[36m•\u001b[39m `` -> `...26`\n",
      "\u001b[36m•\u001b[39m `` -> `...27`\n",
      "\u001b[36m•\u001b[39m `` -> `...28`\n",
      "\u001b[36m•\u001b[39m `` -> `...29`\n",
      "\u001b[36m•\u001b[39m `` -> `...30`\n",
      "\u001b[36m•\u001b[39m `` -> `...31`\n",
      "\u001b[36m•\u001b[39m `` -> `...32`\n",
      "\u001b[36m•\u001b[39m `` -> `...33`\n",
      "\u001b[36m•\u001b[39m `` -> `...34`\n",
      "\u001b[36m•\u001b[39m `` -> `...35`\n",
      "\u001b[36m•\u001b[39m `` -> `...36`\n",
      "\u001b[36m•\u001b[39m `` -> `...37`\n",
      "\u001b[36m•\u001b[39m `` -> `...38`\n",
      "\u001b[36m•\u001b[39m `` -> `...39`\n",
      "\u001b[36m•\u001b[39m `` -> `...40`\n",
      "\u001b[36m•\u001b[39m `` -> `...41`\n",
      "\u001b[36m•\u001b[39m `` -> `...42`\n",
      "\u001b[36m•\u001b[39m `` -> `...43`\n",
      "\u001b[36m•\u001b[39m `` -> `...44`\n",
      "\u001b[36m•\u001b[39m `` -> `...45`\n",
      "\u001b[36m•\u001b[39m `` -> `...46`\n",
      "\u001b[36m•\u001b[39m `` -> `...47`\n",
      "\u001b[36m•\u001b[39m `` -> `...48`\n",
      "\u001b[36m•\u001b[39m `` -> `...49`\n",
      "\u001b[36m•\u001b[39m `` -> `...50`\n",
      "\u001b[36m•\u001b[39m `` -> `...51`\n",
      "\u001b[36m•\u001b[39m `` -> `...52`\n",
      "\u001b[36m•\u001b[39m `` -> `...53`\n",
      "\u001b[36m•\u001b[39m `` -> `...54`\n",
      "\u001b[36m•\u001b[39m `` -> `...55`\n",
      "\u001b[36m•\u001b[39m `` -> `...56`\n",
      "\u001b[36m•\u001b[39m `` -> `...57`\n",
      "\u001b[36m•\u001b[39m `` -> `...58`\n",
      "\u001b[36m•\u001b[39m `` -> `...59`\n",
      "\u001b[36m•\u001b[39m `` -> `...60`\n",
      "\u001b[36m•\u001b[39m `` -> `...61`\n",
      "\u001b[36m•\u001b[39m `` -> `...62`\n",
      "\u001b[36m•\u001b[39m `` -> `...63`\n",
      "\u001b[36m•\u001b[39m `` -> `...64`\n",
      "\u001b[36m•\u001b[39m `` -> `...65`\n",
      "\u001b[36m•\u001b[39m `` -> `...66`\n",
      "\u001b[36m•\u001b[39m `` -> `...67`\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m270\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m67\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (4): Data Source, World Development Indicators, ...3, ...4\n",
      "\u001b[32mdbl\u001b[39m (63): ...5, ...6, ...7, ...8, ...9, ...10, ...11, ...12, ...13, ...14, ....\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 67</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Data Source</th><th scope=col>World Development Indicators</th><th scope=col>...3</th><th scope=col>...4</th><th scope=col>...5</th><th scope=col>...6</th><th scope=col>...7</th><th scope=col>...8</th><th scope=col>...9</th><th scope=col>...10</th><th scope=col>⋯</th><th scope=col>...58</th><th scope=col>...59</th><th scope=col>...60</th><th scope=col>...61</th><th scope=col>...62</th><th scope=col>...63</th><th scope=col>...64</th><th scope=col>...65</th><th scope=col>...66</th><th scope=col>...67</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>NA                         </td><td>NA          </td><td>NA                          </td><td>NA            </td><td>  NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>⋯</td><td>         NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>           NA</td><td>           NA</td></tr>\n",
       "\t<tr><td>Last Updated Date          </td><td>2023-07-25  </td><td>NA                          </td><td>NA            </td><td>  NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>⋯</td><td>         NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>           NA</td><td>           NA</td></tr>\n",
       "\t<tr><td>NA                         </td><td>NA          </td><td>NA                          </td><td>NA            </td><td>  NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>         NA</td><td>⋯</td><td>         NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>          NA</td><td>           NA</td><td>           NA</td></tr>\n",
       "\t<tr><td>Country Name               </td><td>Country Code</td><td>Indicator Name              </td><td>Indicator Code</td><td>1960</td><td>1961.000000</td><td>1962.000000</td><td>1963.000000</td><td>1964.000000</td><td>1965.000000</td><td>⋯</td><td>2013.000000</td><td>2014.0000000</td><td>2015.0000000</td><td>2016.0000000</td><td>2017.0000000</td><td>2018.0000000</td><td>2019.0000000</td><td>2020.0000000</td><td>2021.00000000</td><td>2022.00000000</td></tr>\n",
       "\t<tr><td>Aruba                      </td><td>ABW         </td><td>Population growth (annual %)</td><td>SP.POP.GROW   </td><td>  NA</td><td>   2.179059</td><td>   1.548572</td><td>   1.389337</td><td>   1.215721</td><td>   1.032841</td><td>⋯</td><td>   0.749301</td><td>   0.6916153</td><td>   0.6379592</td><td>   0.5900625</td><td>   0.5372957</td><td>   0.4947953</td><td>   0.4519697</td><td>   0.1342553</td><td>  -0.04504462</td><td>  -0.08639228</td></tr>\n",
       "\t<tr><td>Africa Eastern and Southern</td><td>AFE         </td><td>Population growth (annual %)</td><td>SP.POP.GROW   </td><td>  NA</td><td>   2.660180</td><td>   2.732633</td><td>   2.753248</td><td>   2.806915</td><td>   2.840787</td><td>⋯</td><td>   2.780207</td><td>   2.7749903</td><td>   2.8025858</td><td>   2.7281585</td><td>   2.6556716</td><td>   2.6883714</td><td>   2.6911344</td><td>   2.6781837</td><td>   2.60747169</td><td>   2.54093737</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 67\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " Data Source & World Development Indicators & ...3 & ...4 & ...5 & ...6 & ...7 & ...8 & ...9 & ...10 & ⋯ & ...58 & ...59 & ...60 & ...61 & ...62 & ...63 & ...64 & ...65 & ...66 & ...67\\\\\n",
       " <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t NA                          & NA           & NA                           & NA             &   NA &          NA &          NA &          NA &          NA &          NA & ⋯ &          NA &           NA &           NA &           NA &           NA &           NA &           NA &           NA &            NA &            NA\\\\\n",
       "\t Last Updated Date           & 2023-07-25   & NA                           & NA             &   NA &          NA &          NA &          NA &          NA &          NA & ⋯ &          NA &           NA &           NA &           NA &           NA &           NA &           NA &           NA &            NA &            NA\\\\\n",
       "\t NA                          & NA           & NA                           & NA             &   NA &          NA &          NA &          NA &          NA &          NA & ⋯ &          NA &           NA &           NA &           NA &           NA &           NA &           NA &           NA &            NA &            NA\\\\\n",
       "\t Country Name                & Country Code & Indicator Name               & Indicator Code & 1960 & 1961.000000 & 1962.000000 & 1963.000000 & 1964.000000 & 1965.000000 & ⋯ & 2013.000000 & 2014.0000000 & 2015.0000000 & 2016.0000000 & 2017.0000000 & 2018.0000000 & 2019.0000000 & 2020.0000000 & 2021.00000000 & 2022.00000000\\\\\n",
       "\t Aruba                       & ABW          & Population growth (annual \\%) & SP.POP.GROW    &   NA &    2.179059 &    1.548572 &    1.389337 &    1.215721 &    1.032841 & ⋯ &    0.749301 &    0.6916153 &    0.6379592 &    0.5900625 &    0.5372957 &    0.4947953 &    0.4519697 &    0.1342553 &   -0.04504462 &   -0.08639228\\\\\n",
       "\t Africa Eastern and Southern & AFE          & Population growth (annual \\%) & SP.POP.GROW    &   NA &    2.660180 &    2.732633 &    2.753248 &    2.806915 &    2.840787 & ⋯ &    2.780207 &    2.7749903 &    2.8025858 &    2.7281585 &    2.6556716 &    2.6883714 &    2.6911344 &    2.6781837 &    2.60747169 &    2.54093737\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 67\n",
       "\n",
       "| Data Source &lt;chr&gt; | World Development Indicators &lt;chr&gt; | ...3 &lt;chr&gt; | ...4 &lt;chr&gt; | ...5 &lt;dbl&gt; | ...6 &lt;dbl&gt; | ...7 &lt;dbl&gt; | ...8 &lt;dbl&gt; | ...9 &lt;dbl&gt; | ...10 &lt;dbl&gt; | ⋯ ⋯ | ...58 &lt;dbl&gt; | ...59 &lt;dbl&gt; | ...60 &lt;dbl&gt; | ...61 &lt;dbl&gt; | ...62 &lt;dbl&gt; | ...63 &lt;dbl&gt; | ...64 &lt;dbl&gt; | ...65 &lt;dbl&gt; | ...66 &lt;dbl&gt; | ...67 &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| NA                          | NA           | NA                           | NA             |   NA |          NA |          NA |          NA |          NA |          NA | ⋯ |          NA |           NA |           NA |           NA |           NA |           NA |           NA |           NA |            NA |            NA |\n",
       "| Last Updated Date           | 2023-07-25   | NA                           | NA             |   NA |          NA |          NA |          NA |          NA |          NA | ⋯ |          NA |           NA |           NA |           NA |           NA |           NA |           NA |           NA |            NA |            NA |\n",
       "| NA                          | NA           | NA                           | NA             |   NA |          NA |          NA |          NA |          NA |          NA | ⋯ |          NA |           NA |           NA |           NA |           NA |           NA |           NA |           NA |            NA |            NA |\n",
       "| Country Name                | Country Code | Indicator Name               | Indicator Code | 1960 | 1961.000000 | 1962.000000 | 1963.000000 | 1964.000000 | 1965.000000 | ⋯ | 2013.000000 | 2014.0000000 | 2015.0000000 | 2016.0000000 | 2017.0000000 | 2018.0000000 | 2019.0000000 | 2020.0000000 | 2021.00000000 | 2022.00000000 |\n",
       "| Aruba                       | ABW          | Population growth (annual %) | SP.POP.GROW    |   NA |    2.179059 |    1.548572 |    1.389337 |    1.215721 |    1.032841 | ⋯ |    0.749301 |    0.6916153 |    0.6379592 |    0.5900625 |    0.5372957 |    0.4947953 |    0.4519697 |    0.1342553 |   -0.04504462 |   -0.08639228 |\n",
       "| Africa Eastern and Southern | AFE          | Population growth (annual %) | SP.POP.GROW    |   NA |    2.660180 |    2.732633 |    2.753248 |    2.806915 |    2.840787 | ⋯ |    2.780207 |    2.7749903 |    2.8025858 |    2.7281585 |    2.6556716 |    2.6883714 |    2.6911344 |    2.6781837 |    2.60747169 |    2.54093737 |\n",
       "\n"
      ],
      "text/plain": [
       "  Data Source                 World Development Indicators\n",
       "1 NA                          NA                          \n",
       "2 Last Updated Date           2023-07-25                  \n",
       "3 NA                          NA                          \n",
       "4 Country Name                Country Code                \n",
       "5 Aruba                       ABW                         \n",
       "6 Africa Eastern and Southern AFE                         \n",
       "  ...3                         ...4           ...5 ...6        ...7       \n",
       "1 NA                           NA               NA          NA          NA\n",
       "2 NA                           NA               NA          NA          NA\n",
       "3 NA                           NA               NA          NA          NA\n",
       "4 Indicator Name               Indicator Code 1960 1961.000000 1962.000000\n",
       "5 Population growth (annual %) SP.POP.GROW      NA    2.179059    1.548572\n",
       "6 Population growth (annual %) SP.POP.GROW      NA    2.660180    2.732633\n",
       "  ...8        ...9        ...10       ⋯ ...58       ...59        ...60       \n",
       "1          NA          NA          NA ⋯          NA           NA           NA\n",
       "2          NA          NA          NA ⋯          NA           NA           NA\n",
       "3          NA          NA          NA ⋯          NA           NA           NA\n",
       "4 1963.000000 1964.000000 1965.000000 ⋯ 2013.000000 2014.0000000 2015.0000000\n",
       "5    1.389337    1.215721    1.032841 ⋯    0.749301    0.6916153    0.6379592\n",
       "6    2.753248    2.806915    2.840787 ⋯    2.780207    2.7749903    2.8025858\n",
       "  ...61        ...62        ...63        ...64        ...65       \n",
       "1           NA           NA           NA           NA           NA\n",
       "2           NA           NA           NA           NA           NA\n",
       "3           NA           NA           NA           NA           NA\n",
       "4 2016.0000000 2017.0000000 2018.0000000 2019.0000000 2020.0000000\n",
       "5    0.5900625    0.5372957    0.4947953    0.4519697    0.1342553\n",
       "6    2.7281585    2.6556716    2.6883714    2.6911344    2.6781837\n",
       "  ...66         ...67        \n",
       "1            NA            NA\n",
       "2            NA            NA\n",
       "3            NA            NA\n",
       "4 2021.00000000 2022.00000000\n",
       "5   -0.04504462   -0.08639228\n",
       "6    2.60747169    2.54093737"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "global_pop_growth <- read_csv(\"/kaggle/input/canada-population-vs-housing-price/global_pop_growth.csv\")\n",
    "head(global_pop_growth)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "445da038",
   "metadata": {
    "papermill": {
     "duration": 0.024137,
     "end_time": "2023-09-06T14:22:30.828401",
     "exception": false,
     "start_time": "2023-09-06T14:22:30.804264",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Noticing columns in this dataset are wrongly named, due to they put data source and last updated date of Jul 25, 2023 on the first 3 rows of the dataset. In this case, it would be easier to change directly on excel.\n",
    "\n",
    "Here what we have after delete first 3 rows"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "36c73c00",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:30.879501Z",
     "iopub.status.busy": "2023-09-06T14:22:30.877772Z",
     "iopub.status.idle": "2023-09-06T14:22:31.061493Z",
     "shell.execute_reply": "2023-09-06T14:22:31.059695Z"
    },
    "papermill": {
     "duration": 0.211903,
     "end_time": "2023-09-06T14:22:31.063957",
     "exception": false,
     "start_time": "2023-09-06T14:22:30.852054",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m267\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m67\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (4): Country Name, Country Code, Indicator Name, Indicator Code\n",
      "\u001b[32mdbl\u001b[39m (62): 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, 1971, ...\n",
      "\u001b[33mlgl\u001b[39m  (1): 1960\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 67</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Country Name</th><th scope=col>Country Code</th><th scope=col>Indicator Name</th><th scope=col>Indicator Code</th><th scope=col>1960</th><th scope=col>1961</th><th scope=col>1962</th><th scope=col>1963</th><th scope=col>1964</th><th scope=col>1965</th><th scope=col>⋯</th><th scope=col>2013</th><th scope=col>2014</th><th scope=col>2015</th><th scope=col>2016</th><th scope=col>2017</th><th scope=col>2018</th><th scope=col>2019</th><th scope=col>2020</th><th scope=col>2021</th><th scope=col>2022</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Aruba                      </td><td>ABW</td><td>Population growth (annual %)</td><td>SP.POP.GROW</td><td>NA</td><td>2.179059</td><td>1.548572</td><td>1.389337</td><td>1.215721</td><td>1.032841</td><td>⋯</td><td> 0.7493010</td><td> 0.6916153</td><td> 0.6379592</td><td> 0.5900625</td><td> 0.53729571</td><td> 0.4947953</td><td> 0.4519697</td><td> 0.1342553</td><td>-0.04504462</td><td>-0.08639228</td></tr>\n",
       "\t<tr><td>Africa Eastern and Southern</td><td>AFE</td><td>Population growth (annual %)</td><td>SP.POP.GROW</td><td>NA</td><td>2.660180</td><td>2.732633</td><td>2.753248</td><td>2.806915</td><td>2.840787</td><td>⋯</td><td> 2.7802068</td><td> 2.7749903</td><td> 2.8025858</td><td> 2.7281585</td><td> 2.65567160</td><td> 2.6883714</td><td> 2.6911344</td><td> 2.6781837</td><td> 2.60747169</td><td> 2.54093737</td></tr>\n",
       "\t<tr><td>Afghanistan                </td><td>AFG</td><td>Population growth (annual %)</td><td>SP.POP.GROW</td><td>NA</td><td>1.925952</td><td>2.014879</td><td>2.078997</td><td>2.139651</td><td>2.216007</td><td>⋯</td><td> 3.4667883</td><td> 3.6575761</td><td> 3.1213412</td><td> 2.5815494</td><td> 2.86649215</td><td> 2.8852080</td><td> 2.9085291</td><td> 3.1347469</td><td> 2.85135765</td><td> 2.53449832</td></tr>\n",
       "\t<tr><td>Africa Western and Central </td><td>AFW</td><td>Population growth (annual %)</td><td>SP.POP.GROW</td><td>NA</td><td>2.115789</td><td>2.145723</td><td>2.190827</td><td>2.211360</td><td>2.242567</td><td>⋯</td><td> 2.7618390</td><td> 2.7507306</td><td> 2.7233173</td><td> 2.7130585</td><td> 2.70626608</td><td> 2.6692387</td><td> 2.6339821</td><td> 2.6156461</td><td> 2.57337740</td><td> 2.53979944</td></tr>\n",
       "\t<tr><td>Angola                     </td><td>AGO</td><td>Population growth (annual %)</td><td>SP.POP.GROW</td><td>NA</td><td>1.558355</td><td>1.460738</td><td>1.410425</td><td>1.301745</td><td>1.111041</td><td>⋯</td><td> 3.7355254</td><td> 3.6844290</td><td> 3.6176775</td><td> 3.5862110</td><td> 3.55098664</td><td> 3.4644570</td><td> 3.3952778</td><td> 3.2683484</td><td> 3.16602986</td><td> 3.09675267</td></tr>\n",
       "\t<tr><td>Albania                    </td><td>ALB</td><td>Population growth (annual %)</td><td>SP.POP.GROW</td><td>NA</td><td>3.120855</td><td>3.056731</td><td>2.953749</td><td>2.880686</td><td>2.754021</td><td>⋯</td><td>-0.1832114</td><td>-0.2070470</td><td>-0.2912058</td><td>-0.1598804</td><td>-0.09197229</td><td>-0.2467320</td><td>-0.4260074</td><td>-0.5742070</td><td>-0.92691806</td><td>-1.28980007</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 67\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " Country Name & Country Code & Indicator Name & Indicator Code & 1960 & 1961 & 1962 & 1963 & 1964 & 1965 & ⋯ & 2013 & 2014 & 2015 & 2016 & 2017 & 2018 & 2019 & 2020 & 2021 & 2022\\\\\n",
       " <chr> & <chr> & <chr> & <chr> & <lgl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Aruba                       & ABW & Population growth (annual \\%) & SP.POP.GROW & NA & 2.179059 & 1.548572 & 1.389337 & 1.215721 & 1.032841 & ⋯ &  0.7493010 &  0.6916153 &  0.6379592 &  0.5900625 &  0.53729571 &  0.4947953 &  0.4519697 &  0.1342553 & -0.04504462 & -0.08639228\\\\\n",
       "\t Africa Eastern and Southern & AFE & Population growth (annual \\%) & SP.POP.GROW & NA & 2.660180 & 2.732633 & 2.753248 & 2.806915 & 2.840787 & ⋯ &  2.7802068 &  2.7749903 &  2.8025858 &  2.7281585 &  2.65567160 &  2.6883714 &  2.6911344 &  2.6781837 &  2.60747169 &  2.54093737\\\\\n",
       "\t Afghanistan                 & AFG & Population growth (annual \\%) & SP.POP.GROW & NA & 1.925952 & 2.014879 & 2.078997 & 2.139651 & 2.216007 & ⋯ &  3.4667883 &  3.6575761 &  3.1213412 &  2.5815494 &  2.86649215 &  2.8852080 &  2.9085291 &  3.1347469 &  2.85135765 &  2.53449832\\\\\n",
       "\t Africa Western and Central  & AFW & Population growth (annual \\%) & SP.POP.GROW & NA & 2.115789 & 2.145723 & 2.190827 & 2.211360 & 2.242567 & ⋯ &  2.7618390 &  2.7507306 &  2.7233173 &  2.7130585 &  2.70626608 &  2.6692387 &  2.6339821 &  2.6156461 &  2.57337740 &  2.53979944\\\\\n",
       "\t Angola                      & AGO & Population growth (annual \\%) & SP.POP.GROW & NA & 1.558355 & 1.460738 & 1.410425 & 1.301745 & 1.111041 & ⋯ &  3.7355254 &  3.6844290 &  3.6176775 &  3.5862110 &  3.55098664 &  3.4644570 &  3.3952778 &  3.2683484 &  3.16602986 &  3.09675267\\\\\n",
       "\t Albania                     & ALB & Population growth (annual \\%) & SP.POP.GROW & NA & 3.120855 & 3.056731 & 2.953749 & 2.880686 & 2.754021 & ⋯ & -0.1832114 & -0.2070470 & -0.2912058 & -0.1598804 & -0.09197229 & -0.2467320 & -0.4260074 & -0.5742070 & -0.92691806 & -1.28980007\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 67\n",
       "\n",
       "| Country Name &lt;chr&gt; | Country Code &lt;chr&gt; | Indicator Name &lt;chr&gt; | Indicator Code &lt;chr&gt; | 1960 &lt;lgl&gt; | 1961 &lt;dbl&gt; | 1962 &lt;dbl&gt; | 1963 &lt;dbl&gt; | 1964 &lt;dbl&gt; | 1965 &lt;dbl&gt; | ⋯ ⋯ | 2013 &lt;dbl&gt; | 2014 &lt;dbl&gt; | 2015 &lt;dbl&gt; | 2016 &lt;dbl&gt; | 2017 &lt;dbl&gt; | 2018 &lt;dbl&gt; | 2019 &lt;dbl&gt; | 2020 &lt;dbl&gt; | 2021 &lt;dbl&gt; | 2022 &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| Aruba                       | ABW | Population growth (annual %) | SP.POP.GROW | NA | 2.179059 | 1.548572 | 1.389337 | 1.215721 | 1.032841 | ⋯ |  0.7493010 |  0.6916153 |  0.6379592 |  0.5900625 |  0.53729571 |  0.4947953 |  0.4519697 |  0.1342553 | -0.04504462 | -0.08639228 |\n",
       "| Africa Eastern and Southern | AFE | Population growth (annual %) | SP.POP.GROW | NA | 2.660180 | 2.732633 | 2.753248 | 2.806915 | 2.840787 | ⋯ |  2.7802068 |  2.7749903 |  2.8025858 |  2.7281585 |  2.65567160 |  2.6883714 |  2.6911344 |  2.6781837 |  2.60747169 |  2.54093737 |\n",
       "| Afghanistan                 | AFG | Population growth (annual %) | SP.POP.GROW | NA | 1.925952 | 2.014879 | 2.078997 | 2.139651 | 2.216007 | ⋯ |  3.4667883 |  3.6575761 |  3.1213412 |  2.5815494 |  2.86649215 |  2.8852080 |  2.9085291 |  3.1347469 |  2.85135765 |  2.53449832 |\n",
       "| Africa Western and Central  | AFW | Population growth (annual %) | SP.POP.GROW | NA | 2.115789 | 2.145723 | 2.190827 | 2.211360 | 2.242567 | ⋯ |  2.7618390 |  2.7507306 |  2.7233173 |  2.7130585 |  2.70626608 |  2.6692387 |  2.6339821 |  2.6156461 |  2.57337740 |  2.53979944 |\n",
       "| Angola                      | AGO | Population growth (annual %) | SP.POP.GROW | NA | 1.558355 | 1.460738 | 1.410425 | 1.301745 | 1.111041 | ⋯ |  3.7355254 |  3.6844290 |  3.6176775 |  3.5862110 |  3.55098664 |  3.4644570 |  3.3952778 |  3.2683484 |  3.16602986 |  3.09675267 |\n",
       "| Albania                     | ALB | Population growth (annual %) | SP.POP.GROW | NA | 3.120855 | 3.056731 | 2.953749 | 2.880686 | 2.754021 | ⋯ | -0.1832114 | -0.2070470 | -0.2912058 | -0.1598804 | -0.09197229 | -0.2467320 | -0.4260074 | -0.5742070 | -0.92691806 | -1.28980007 |\n",
       "\n"
      ],
      "text/plain": [
       "  Country Name                Country Code Indicator Name              \n",
       "1 Aruba                       ABW          Population growth (annual %)\n",
       "2 Africa Eastern and Southern AFE          Population growth (annual %)\n",
       "3 Afghanistan                 AFG          Population growth (annual %)\n",
       "4 Africa Western and Central  AFW          Population growth (annual %)\n",
       "5 Angola                      AGO          Population growth (annual %)\n",
       "6 Albania                     ALB          Population growth (annual %)\n",
       "  Indicator Code 1960 1961     1962     1963     1964     1965     ⋯ 2013      \n",
       "1 SP.POP.GROW    NA   2.179059 1.548572 1.389337 1.215721 1.032841 ⋯  0.7493010\n",
       "2 SP.POP.GROW    NA   2.660180 2.732633 2.753248 2.806915 2.840787 ⋯  2.7802068\n",
       "3 SP.POP.GROW    NA   1.925952 2.014879 2.078997 2.139651 2.216007 ⋯  3.4667883\n",
       "4 SP.POP.GROW    NA   2.115789 2.145723 2.190827 2.211360 2.242567 ⋯  2.7618390\n",
       "5 SP.POP.GROW    NA   1.558355 1.460738 1.410425 1.301745 1.111041 ⋯  3.7355254\n",
       "6 SP.POP.GROW    NA   3.120855 3.056731 2.953749 2.880686 2.754021 ⋯ -0.1832114\n",
       "  2014       2015       2016       2017        2018       2019       2020      \n",
       "1  0.6916153  0.6379592  0.5900625  0.53729571  0.4947953  0.4519697  0.1342553\n",
       "2  2.7749903  2.8025858  2.7281585  2.65567160  2.6883714  2.6911344  2.6781837\n",
       "3  3.6575761  3.1213412  2.5815494  2.86649215  2.8852080  2.9085291  3.1347469\n",
       "4  2.7507306  2.7233173  2.7130585  2.70626608  2.6692387  2.6339821  2.6156461\n",
       "5  3.6844290  3.6176775  3.5862110  3.55098664  3.4644570  3.3952778  3.2683484\n",
       "6 -0.2070470 -0.2912058 -0.1598804 -0.09197229 -0.2467320 -0.4260074 -0.5742070\n",
       "  2021        2022       \n",
       "1 -0.04504462 -0.08639228\n",
       "2  2.60747169  2.54093737\n",
       "3  2.85135765  2.53449832\n",
       "4  2.57337740  2.53979944\n",
       "5  3.16602986  3.09675267\n",
       "6 -0.92691806 -1.28980007"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "world_population_growth <- read_csv(\"/kaggle/input/canada-population-vs-housing-price/world_population_growth.csv\")\n",
    "view(world_population_growth)\n",
    "head(world_population_growth)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "42d882ed",
   "metadata": {
    "papermill": {
     "duration": 0.023959,
     "end_time": "2023-09-06T14:22:31.111996",
     "exception": false,
     "start_time": "2023-09-06T14:22:31.088037",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Another point is that the columns name should use \"_\" instead of space to avoid errors later.\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "cd6077fd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:31.170454Z",
     "iopub.status.busy": "2023-09-06T14:22:31.168779Z",
     "iopub.status.idle": "2023-09-06T14:22:31.203490Z",
     "shell.execute_reply": "2023-09-06T14:22:31.201569Z"
    },
    "papermill": {
     "duration": 0.070639,
     "end_time": "2023-09-06T14:22:31.206782",
     "exception": false,
     "start_time": "2023-09-06T14:22:31.136143",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "world_population_growth <- world_population_growth %>% \n",
    "  rename(country_name = `Country Name`, country_code = 'Country Code', indicator_name = 'Indicator Name', indicator_code = 'Indicator Code')"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9ef1c450",
   "metadata": {
    "papermill": {
     "duration": 0.024125,
     "end_time": "2023-09-06T14:22:31.254879",
     "exception": false,
     "start_time": "2023-09-06T14:22:31.230754",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Housing price"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "cb1b1236",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:31.306839Z",
     "iopub.status.busy": "2023-09-06T14:22:31.305180Z",
     "iopub.status.idle": "2023-09-06T14:22:31.579871Z",
     "shell.execute_reply": "2023-09-06T14:22:31.577314Z"
    },
    "papermill": {
     "duration": 0.304118,
     "end_time": "2023-09-06T14:22:31.583223",
     "exception": false,
     "start_time": "2023-09-06T14:22:31.279105",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m61320\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m15\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): GEO, DGUID, New housing price indexes, UOM, SCALAR_FACTOR, VECTOR,...\n",
      "\u001b[32mdbl\u001b[39m  (5): UOM_ID, SCALAR_ID, COORDINATE, VALUE, DECIMALS\n",
      "\u001b[33mlgl\u001b[39m  (2): SYMBOL, TERMINATED\n",
      "\u001b[34mdate\u001b[39m (1): REF_DATE\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>REF_DATE</th><th scope=col>GEO</th><th scope=col>DGUID</th><th scope=col>New housing price indexes</th><th scope=col>UOM</th><th scope=col>UOM_ID</th><th scope=col>SCALAR_FACTOR</th><th scope=col>SCALAR_ID</th><th scope=col>VECTOR</th><th scope=col>COORDINATE</th><th scope=col>VALUE</th><th scope=col>STATUS</th><th scope=col>SYMBOL</th><th scope=col>TERMINATED</th><th scope=col>DECIMALS</th></tr>\n",
       "\t<tr><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1981-01-01</td><td>Canada         </td><td>2016A000011124</td><td>Total (house and land)</td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955442</td><td>1.1</td><td>38.2</td><td>NA</td><td>NA</td><td>NA</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Canada         </td><td>2016A000011124</td><td>House only            </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955443</td><td>1.2</td><td>36.1</td><td>NA</td><td>NA</td><td>NA</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Canada         </td><td>2016A000011124</td><td>Land only             </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955444</td><td>1.3</td><td>40.6</td><td>E </td><td>NA</td><td>NA</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Atlantic Region</td><td>2016A00011    </td><td>Total (house and land)</td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955445</td><td>2.1</td><td>  NA</td><td>..</td><td>NA</td><td>NA</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Atlantic Region</td><td>2016A00011    </td><td>House only            </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955446</td><td>2.2</td><td>  NA</td><td>..</td><td>NA</td><td>NA</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Atlantic Region</td><td>2016A00011    </td><td>Land only             </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955447</td><td>2.3</td><td>  NA</td><td>..</td><td>NA</td><td>NA</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 15\n",
       "\\begin{tabular}{lllllllllllllll}\n",
       " REF\\_DATE & GEO & DGUID & New housing price indexes & UOM & UOM\\_ID & SCALAR\\_FACTOR & SCALAR\\_ID & VECTOR & COORDINATE & VALUE & STATUS & SYMBOL & TERMINATED & DECIMALS\\\\\n",
       " <date> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <chr> & <lgl> & <lgl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1981-01-01 & Canada          & 2016A000011124 & Total (house and land) & Index, 201612=100 & 347 & units & 0 & v111955442 & 1.1 & 38.2 & NA & NA & NA & 1\\\\\n",
       "\t 1981-01-01 & Canada          & 2016A000011124 & House only             & Index, 201612=100 & 347 & units & 0 & v111955443 & 1.2 & 36.1 & NA & NA & NA & 1\\\\\n",
       "\t 1981-01-01 & Canada          & 2016A000011124 & Land only              & Index, 201612=100 & 347 & units & 0 & v111955444 & 1.3 & 40.6 & E  & NA & NA & 1\\\\\n",
       "\t 1981-01-01 & Atlantic Region & 2016A00011     & Total (house and land) & Index, 201612=100 & 347 & units & 0 & v111955445 & 2.1 &   NA & .. & NA & NA & 1\\\\\n",
       "\t 1981-01-01 & Atlantic Region & 2016A00011     & House only             & Index, 201612=100 & 347 & units & 0 & v111955446 & 2.2 &   NA & .. & NA & NA & 1\\\\\n",
       "\t 1981-01-01 & Atlantic Region & 2016A00011     & Land only              & Index, 201612=100 & 347 & units & 0 & v111955447 & 2.3 &   NA & .. & NA & NA & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 15\n",
       "\n",
       "| REF_DATE &lt;date&gt; | GEO &lt;chr&gt; | DGUID &lt;chr&gt; | New housing price indexes &lt;chr&gt; | UOM &lt;chr&gt; | UOM_ID &lt;dbl&gt; | SCALAR_FACTOR &lt;chr&gt; | SCALAR_ID &lt;dbl&gt; | VECTOR &lt;chr&gt; | COORDINATE &lt;dbl&gt; | VALUE &lt;dbl&gt; | STATUS &lt;chr&gt; | SYMBOL &lt;lgl&gt; | TERMINATED &lt;lgl&gt; | DECIMALS &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1981-01-01 | Canada          | 2016A000011124 | Total (house and land) | Index, 201612=100 | 347 | units | 0 | v111955442 | 1.1 | 38.2 | NA | NA | NA | 1 |\n",
       "| 1981-01-01 | Canada          | 2016A000011124 | House only             | Index, 201612=100 | 347 | units | 0 | v111955443 | 1.2 | 36.1 | NA | NA | NA | 1 |\n",
       "| 1981-01-01 | Canada          | 2016A000011124 | Land only              | Index, 201612=100 | 347 | units | 0 | v111955444 | 1.3 | 40.6 | E  | NA | NA | 1 |\n",
       "| 1981-01-01 | Atlantic Region | 2016A00011     | Total (house and land) | Index, 201612=100 | 347 | units | 0 | v111955445 | 2.1 |   NA | .. | NA | NA | 1 |\n",
       "| 1981-01-01 | Atlantic Region | 2016A00011     | House only             | Index, 201612=100 | 347 | units | 0 | v111955446 | 2.2 |   NA | .. | NA | NA | 1 |\n",
       "| 1981-01-01 | Atlantic Region | 2016A00011     | Land only              | Index, 201612=100 | 347 | units | 0 | v111955447 | 2.3 |   NA | .. | NA | NA | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  REF_DATE   GEO             DGUID          New housing price indexes\n",
       "1 1981-01-01 Canada          2016A000011124 Total (house and land)   \n",
       "2 1981-01-01 Canada          2016A000011124 House only               \n",
       "3 1981-01-01 Canada          2016A000011124 Land only                \n",
       "4 1981-01-01 Atlantic Region 2016A00011     Total (house and land)   \n",
       "5 1981-01-01 Atlantic Region 2016A00011     House only               \n",
       "6 1981-01-01 Atlantic Region 2016A00011     Land only                \n",
       "  UOM               UOM_ID SCALAR_FACTOR SCALAR_ID VECTOR     COORDINATE VALUE\n",
       "1 Index, 201612=100 347    units         0         v111955442 1.1        38.2 \n",
       "2 Index, 201612=100 347    units         0         v111955443 1.2        36.1 \n",
       "3 Index, 201612=100 347    units         0         v111955444 1.3        40.6 \n",
       "4 Index, 201612=100 347    units         0         v111955445 2.1          NA \n",
       "5 Index, 201612=100 347    units         0         v111955446 2.2          NA \n",
       "6 Index, 201612=100 347    units         0         v111955447 2.3          NA \n",
       "  STATUS SYMBOL TERMINATED DECIMALS\n",
       "1 NA     NA     NA         1       \n",
       "2 NA     NA     NA         1       \n",
       "3 E      NA     NA         1       \n",
       "4 ..     NA     NA         1       \n",
       "5 ..     NA     NA         1       \n",
       "6 ..     NA     NA         1       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "housing_price <- read_csv(\"/kaggle/input/canada-population-vs-housing-price/housing_price.csv\")\n",
    "head(housing_price)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "08ee8e43",
   "metadata": {
    "papermill": {
     "duration": 0.025922,
     "end_time": "2023-09-06T14:22:31.634906",
     "exception": false,
     "start_time": "2023-09-06T14:22:31.608984",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Permanent Residents (PR) by provinces"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "6aa9b0db",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:31.688717Z",
     "iopub.status.busy": "2023-09-06T14:22:31.686939Z",
     "iopub.status.idle": "2023-09-06T14:22:34.487480Z",
     "shell.execute_reply": "2023-09-06T14:22:34.485494Z"
    },
    "papermill": {
     "duration": 2.830268,
     "end_time": "2023-09-06T14:22:34.490302",
     "exception": false,
     "start_time": "2023-09-06T14:22:31.660034",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22mNew names:\n",
      "\u001b[36m•\u001b[39m `` -> `...2`\n",
      "\u001b[36m•\u001b[39m `` -> `...3`\n",
      "\u001b[36m•\u001b[39m `` -> `...4`\n",
      "\u001b[36m•\u001b[39m `` -> `...5`\n",
      "\u001b[36m•\u001b[39m `` -> `...6`\n",
      "\u001b[36m•\u001b[39m `` -> `...7`\n",
      "\u001b[36m•\u001b[39m `` -> `...8`\n",
      "\u001b[36m•\u001b[39m `` -> `...9`\n",
      "\u001b[36m•\u001b[39m `` -> `...10`\n",
      "\u001b[36m•\u001b[39m `` -> `...11`\n",
      "\u001b[36m•\u001b[39m `` -> `...12`\n",
      "\u001b[36m•\u001b[39m `` -> `...13`\n",
      "\u001b[36m•\u001b[39m `` -> `...14`\n",
      "\u001b[36m•\u001b[39m `` -> `...15`\n",
      "\u001b[36m•\u001b[39m `` -> `...16`\n",
      "\u001b[36m•\u001b[39m `` -> `...17`\n",
      "\u001b[36m•\u001b[39m `` -> `...18`\n",
      "\u001b[36m•\u001b[39m `` -> `...19`\n",
      "\u001b[36m•\u001b[39m `` -> `...20`\n",
      "\u001b[36m•\u001b[39m `` -> `...21`\n",
      "\u001b[36m•\u001b[39m `` -> `...22`\n",
      "\u001b[36m•\u001b[39m `` -> `...23`\n",
      "\u001b[36m•\u001b[39m `` -> `...24`\n",
      "\u001b[36m•\u001b[39m `` -> `...25`\n",
      "\u001b[36m•\u001b[39m `` -> `...26`\n",
      "\u001b[36m•\u001b[39m `` -> `...27`\n",
      "\u001b[36m•\u001b[39m `` -> `...28`\n",
      "\u001b[36m•\u001b[39m `` -> `...29`\n",
      "\u001b[36m•\u001b[39m `` -> `...30`\n",
      "\u001b[36m•\u001b[39m `` -> `...31`\n",
      "\u001b[36m•\u001b[39m `` -> `...32`\n",
      "\u001b[36m•\u001b[39m `` -> `...33`\n",
      "\u001b[36m•\u001b[39m `` -> `...34`\n",
      "\u001b[36m•\u001b[39m `` -> `...35`\n",
      "\u001b[36m•\u001b[39m `` -> `...36`\n",
      "\u001b[36m•\u001b[39m `` -> `...37`\n",
      "\u001b[36m•\u001b[39m `` -> `...38`\n",
      "\u001b[36m•\u001b[39m `` -> `...39`\n",
      "\u001b[36m•\u001b[39m `` -> `...40`\n",
      "\u001b[36m•\u001b[39m `` -> `...41`\n",
      "\u001b[36m•\u001b[39m `` -> `...42`\n",
      "\u001b[36m•\u001b[39m `` -> `...43`\n",
      "\u001b[36m•\u001b[39m `` -> `...44`\n",
      "\u001b[36m•\u001b[39m `` -> `...45`\n",
      "\u001b[36m•\u001b[39m `` -> `...46`\n",
      "\u001b[36m•\u001b[39m `` -> `...47`\n",
      "\u001b[36m•\u001b[39m `` -> `...48`\n",
      "\u001b[36m•\u001b[39m `` -> `...49`\n",
      "\u001b[36m•\u001b[39m `` -> `...50`\n",
      "\u001b[36m•\u001b[39m `` -> `...51`\n",
      "\u001b[36m•\u001b[39m `` -> `...52`\n",
      "\u001b[36m•\u001b[39m `` -> `...53`\n",
      "\u001b[36m•\u001b[39m `` -> `...54`\n",
      "\u001b[36m•\u001b[39m `` -> `...55`\n",
      "\u001b[36m•\u001b[39m `` -> `...56`\n",
      "\u001b[36m•\u001b[39m `` -> `...57`\n",
      "\u001b[36m•\u001b[39m `` -> `...58`\n",
      "\u001b[36m•\u001b[39m `` -> `...59`\n",
      "\u001b[36m•\u001b[39m `` -> `...60`\n",
      "\u001b[36m•\u001b[39m `` -> `...61`\n",
      "\u001b[36m•\u001b[39m `` -> `...62`\n",
      "\u001b[36m•\u001b[39m `` -> `...63`\n",
      "\u001b[36m•\u001b[39m `` -> `...64`\n",
      "\u001b[36m•\u001b[39m `` -> `...65`\n",
      "\u001b[36m•\u001b[39m `` -> `...66`\n",
      "\u001b[36m•\u001b[39m `` -> `...67`\n",
      "\u001b[36m•\u001b[39m `` -> `...68`\n",
      "\u001b[36m•\u001b[39m `` -> `...69`\n",
      "\u001b[36m•\u001b[39m `` -> `...70`\n",
      "\u001b[36m•\u001b[39m `` -> `...71`\n",
      "\u001b[36m•\u001b[39m `` -> `...72`\n",
      "\u001b[36m•\u001b[39m `` -> `...73`\n",
      "\u001b[36m•\u001b[39m `` -> `...74`\n",
      "\u001b[36m•\u001b[39m `` -> `...75`\n",
      "\u001b[36m•\u001b[39m `` -> `...76`\n",
      "\u001b[36m•\u001b[39m `` -> `...77`\n",
      "\u001b[36m•\u001b[39m `` -> `...78`\n",
      "\u001b[36m•\u001b[39m `` -> `...79`\n",
      "\u001b[36m•\u001b[39m `` -> `...80`\n",
      "\u001b[36m•\u001b[39m `` -> `...81`\n",
      "\u001b[36m•\u001b[39m `` -> `...82`\n",
      "\u001b[36m•\u001b[39m `` -> `...83`\n",
      "\u001b[36m•\u001b[39m `` -> `...84`\n",
      "\u001b[36m•\u001b[39m `` -> `...85`\n",
      "\u001b[36m•\u001b[39m `` -> `...86`\n",
      "\u001b[36m•\u001b[39m `` -> `...87`\n",
      "\u001b[36m•\u001b[39m `` -> `...88`\n",
      "\u001b[36m•\u001b[39m `` -> `...89`\n",
      "\u001b[36m•\u001b[39m `` -> `...90`\n",
      "\u001b[36m•\u001b[39m `` -> `...91`\n",
      "\u001b[36m•\u001b[39m `` -> `...92`\n",
      "\u001b[36m•\u001b[39m `` -> `...93`\n",
      "\u001b[36m•\u001b[39m `` -> `...94`\n",
      "\u001b[36m•\u001b[39m `` -> `...95`\n",
      "\u001b[36m•\u001b[39m `` -> `...96`\n",
      "\u001b[36m•\u001b[39m `` -> `...97`\n",
      "\u001b[36m•\u001b[39m `` -> `...98`\n",
      "\u001b[36m•\u001b[39m `` -> `...99`\n",
      "\u001b[36m•\u001b[39m `` -> `...100`\n",
      "\u001b[36m•\u001b[39m `` -> `...101`\n",
      "\u001b[36m•\u001b[39m `` -> `...102`\n",
      "\u001b[36m•\u001b[39m `` -> `...103`\n",
      "\u001b[36m•\u001b[39m `` -> `...104`\n",
      "\u001b[36m•\u001b[39m `` -> `...105`\n",
      "\u001b[36m•\u001b[39m `` -> `...106`\n",
      "\u001b[36m•\u001b[39m `` -> `...107`\n",
      "\u001b[36m•\u001b[39m `` -> `...108`\n",
      "\u001b[36m•\u001b[39m `` -> `...109`\n",
      "\u001b[36m•\u001b[39m `` -> `...110`\n",
      "\u001b[36m•\u001b[39m `` -> `...111`\n",
      "\u001b[36m•\u001b[39m `` -> `...112`\n",
      "\u001b[36m•\u001b[39m `` -> `...113`\n",
      "\u001b[36m•\u001b[39m `` -> `...114`\n",
      "\u001b[36m•\u001b[39m `` -> `...115`\n",
      "\u001b[36m•\u001b[39m `` -> `...116`\n",
      "\u001b[36m•\u001b[39m `` -> `...117`\n",
      "\u001b[36m•\u001b[39m `` -> `...118`\n",
      "\u001b[36m•\u001b[39m `` -> `...119`\n",
      "\u001b[36m•\u001b[39m `` -> `...120`\n",
      "\u001b[36m•\u001b[39m `` -> `...121`\n",
      "\u001b[36m•\u001b[39m `` -> `...122`\n",
      "\u001b[36m•\u001b[39m `` -> `...123`\n",
      "\u001b[36m•\u001b[39m `` -> `...124`\n",
      "\u001b[36m•\u001b[39m `` -> `...125`\n",
      "\u001b[36m•\u001b[39m `` -> `...126`\n",
      "\u001b[36m•\u001b[39m `` -> `...127`\n",
      "\u001b[36m•\u001b[39m `` -> `...128`\n",
      "\u001b[36m•\u001b[39m `` -> `...129`\n",
      "\u001b[36m•\u001b[39m `` -> `...130`\n",
      "\u001b[36m•\u001b[39m `` -> `...131`\n",
      "\u001b[36m•\u001b[39m `` -> `...132`\n",
      "\u001b[36m•\u001b[39m `` -> `...133`\n",
      "\u001b[36m•\u001b[39m `` -> `...134`\n",
      "\u001b[36m•\u001b[39m `` -> `...135`\n",
      "\u001b[36m•\u001b[39m `` -> `...136`\n",
      "\u001b[36m•\u001b[39m `` -> `...137`\n",
      "\u001b[36m•\u001b[39m `` -> `...138`\n",
      "\u001b[36m•\u001b[39m `` -> `...139`\n",
      "\u001b[36m•\u001b[39m `` -> `...140`\n",
      "\u001b[36m•\u001b[39m `` -> `...141`\n",
      "\u001b[36m•\u001b[39m `` -> `...142`\n",
      "\u001b[36m•\u001b[39m `` -> `...143`\n",
      "\u001b[36m•\u001b[39m `` -> `...144`\n",
      "\u001b[36m•\u001b[39m `` -> `...145`\n",
      "\u001b[36m•\u001b[39m `` -> `...146`\n",
      "\u001b[36m•\u001b[39m `` -> `...147`\n",
      "\u001b[36m•\u001b[39m `` -> `...148`\n",
      "\u001b[36m•\u001b[39m `` -> `...149`\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 149</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Canada - Admissions of Permanent Residents by Province/Territory of Intended Destination and Immigration Category, January 2015 - June 2023</th><th scope=col>...2</th><th scope=col>...3</th><th scope=col>...4</th><th scope=col>...5</th><th scope=col>...6</th><th scope=col>...7</th><th scope=col>...8</th><th scope=col>...9</th><th scope=col>...10</th><th scope=col>⋯</th><th scope=col>...140</th><th scope=col>...141</th><th scope=col>...142</th><th scope=col>...143</th><th scope=col>...144</th><th scope=col>...145</th><th scope=col>...146</th><th scope=col>...147</th><th scope=col>...148</th><th scope=col>...149</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>⋯</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>NA                                         </td><td>NA</td><td>NA</td><td>NA                                 </td><td>NA  </td><td>NA </td><td>NA </td><td>NA      </td><td>NA </td><td>NA </td><td>⋯</td><td>NA        </td><td>NA  </td><td>NA </td><td>NA </td><td>NA      </td><td>NA </td><td>NA </td><td>NA </td><td>NA      </td><td>NA        </td></tr>\n",
       "\t<tr><td>Province/Territory and Immigration Category</td><td>NA</td><td>NA</td><td>NA                                 </td><td>2015</td><td>NA </td><td>NA </td><td>NA      </td><td>NA </td><td>NA </td><td>⋯</td><td>NA        </td><td>2023</td><td>NA </td><td>NA </td><td>NA      </td><td>NA </td><td>NA </td><td>NA </td><td>NA      </td><td>NA        </td></tr>\n",
       "\t<tr><td>NA                                         </td><td>NA</td><td>NA</td><td>NA                                 </td><td>Q1  </td><td>NA </td><td>NA </td><td>NA      </td><td>Q2 </td><td>NA </td><td>⋯</td><td>2022 Total</td><td>Q1  </td><td>NA </td><td>NA </td><td>NA      </td><td>Q2 </td><td>NA </td><td>NA </td><td>NA      </td><td>2023 Total</td></tr>\n",
       "\t<tr><td>NA                                         </td><td>NA</td><td>NA</td><td>NA                                 </td><td>Jan </td><td>Feb</td><td>Mar</td><td>Q1 Total</td><td>Apr</td><td>May</td><td>⋯</td><td>NA        </td><td>Jan </td><td>Feb</td><td>Mar</td><td>Q1 Total</td><td>Apr</td><td>May</td><td>Jun</td><td>Q2 Total</td><td>NA        </td></tr>\n",
       "\t<tr><td>NA                                         </td><td>NA</td><td>NA</td><td>Atlantic Immigration Pilot Programs</td><td>0   </td><td>0  </td><td>0  </td><td>0       </td><td>0  </td><td>0  </td><td>⋯</td><td>675       </td><td>220 </td><td>100</td><td>75 </td><td>390     </td><td>35 </td><td>65 </td><td>40 </td><td>135     </td><td>530       </td></tr>\n",
       "\t<tr><td>NA                                         </td><td>NA</td><td>NA</td><td>Canadian Experience                </td><td>--  </td><td>0  </td><td>-- </td><td>5       </td><td>-- </td><td>-- </td><td>⋯</td><td>90        </td><td>10  </td><td>10 </td><td>15 </td><td>35      </td><td>5  </td><td>-- </td><td>10 </td><td>20      </td><td>55        </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 149\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " Canada - Admissions of Permanent Residents by Province/Territory of Intended Destination and Immigration Category, January 2015 - June 2023 & ...2 & ...3 & ...4 & ...5 & ...6 & ...7 & ...8 & ...9 & ...10 & ⋯ & ...140 & ...141 & ...142 & ...143 & ...144 & ...145 & ...146 & ...147 & ...148 & ...149\\\\\n",
       " <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & ⋯ & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t NA                                          & NA & NA & NA                                  & NA   & NA  & NA  & NA       & NA  & NA  & ⋯ & NA         & NA   & NA  & NA  & NA       & NA  & NA  & NA  & NA       & NA        \\\\\n",
       "\t Province/Territory and Immigration Category & NA & NA & NA                                  & 2015 & NA  & NA  & NA       & NA  & NA  & ⋯ & NA         & 2023 & NA  & NA  & NA       & NA  & NA  & NA  & NA       & NA        \\\\\n",
       "\t NA                                          & NA & NA & NA                                  & Q1   & NA  & NA  & NA       & Q2  & NA  & ⋯ & 2022 Total & Q1   & NA  & NA  & NA       & Q2  & NA  & NA  & NA       & 2023 Total\\\\\n",
       "\t NA                                          & NA & NA & NA                                  & Jan  & Feb & Mar & Q1 Total & Apr & May & ⋯ & NA         & Jan  & Feb & Mar & Q1 Total & Apr & May & Jun & Q2 Total & NA        \\\\\n",
       "\t NA                                          & NA & NA & Atlantic Immigration Pilot Programs & 0    & 0   & 0   & 0        & 0   & 0   & ⋯ & 675        & 220  & 100 & 75  & 390      & 35  & 65  & 40  & 135      & 530       \\\\\n",
       "\t NA                                          & NA & NA & Canadian Experience                 & --   & 0   & --  & 5        & --  & --  & ⋯ & 90         & 10   & 10  & 15  & 35       & 5   & --  & 10  & 20       & 55        \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 149\n",
       "\n",
       "| Canada - Admissions of Permanent Residents by Province/Territory of Intended Destination and Immigration Category, January 2015 - June 2023 &lt;chr&gt; | ...2 &lt;chr&gt; | ...3 &lt;chr&gt; | ...4 &lt;chr&gt; | ...5 &lt;chr&gt; | ...6 &lt;chr&gt; | ...7 &lt;chr&gt; | ...8 &lt;chr&gt; | ...9 &lt;chr&gt; | ...10 &lt;chr&gt; | ⋯ ⋯ | ...140 &lt;chr&gt; | ...141 &lt;chr&gt; | ...142 &lt;chr&gt; | ...143 &lt;chr&gt; | ...144 &lt;chr&gt; | ...145 &lt;chr&gt; | ...146 &lt;chr&gt; | ...147 &lt;chr&gt; | ...148 &lt;chr&gt; | ...149 &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| NA                                          | NA | NA | NA                                  | NA   | NA  | NA  | NA       | NA  | NA  | ⋯ | NA         | NA   | NA  | NA  | NA       | NA  | NA  | NA  | NA       | NA         |\n",
       "| Province/Territory and Immigration Category | NA | NA | NA                                  | 2015 | NA  | NA  | NA       | NA  | NA  | ⋯ | NA         | 2023 | NA  | NA  | NA       | NA  | NA  | NA  | NA       | NA         |\n",
       "| NA                                          | NA | NA | NA                                  | Q1   | NA  | NA  | NA       | Q2  | NA  | ⋯ | 2022 Total | Q1   | NA  | NA  | NA       | Q2  | NA  | NA  | NA       | 2023 Total |\n",
       "| NA                                          | NA | NA | NA                                  | Jan  | Feb | Mar | Q1 Total | Apr | May | ⋯ | NA         | Jan  | Feb | Mar | Q1 Total | Apr | May | Jun | Q2 Total | NA         |\n",
       "| NA                                          | NA | NA | Atlantic Immigration Pilot Programs | 0    | 0   | 0   | 0        | 0   | 0   | ⋯ | 675        | 220  | 100 | 75  | 390      | 35  | 65  | 40  | 135      | 530        |\n",
       "| NA                                          | NA | NA | Canadian Experience                 | --   | 0   | --  | 5        | --  | --  | ⋯ | 90         | 10   | 10  | 15  | 35       | 5   | --  | 10  | 20       | 55         |\n",
       "\n"
      ],
      "text/plain": [
       "  Canada - Admissions of Permanent Residents by Province/Territory of Intended Destination and Immigration Category, January 2015 - June 2023\n",
       "1 NA                                                                                                                                         \n",
       "2 Province/Territory and Immigration Category                                                                                                \n",
       "3 NA                                                                                                                                         \n",
       "4 NA                                                                                                                                         \n",
       "5 NA                                                                                                                                         \n",
       "6 NA                                                                                                                                         \n",
       "  ...2 ...3 ...4                                ...5 ...6 ...7 ...8     ...9\n",
       "1 NA   NA   NA                                  NA   NA   NA   NA       NA  \n",
       "2 NA   NA   NA                                  2015 NA   NA   NA       NA  \n",
       "3 NA   NA   NA                                  Q1   NA   NA   NA       Q2  \n",
       "4 NA   NA   NA                                  Jan  Feb  Mar  Q1 Total Apr \n",
       "5 NA   NA   Atlantic Immigration Pilot Programs 0    0    0    0        0   \n",
       "6 NA   NA   Canadian Experience                 --   0    --   5        --  \n",
       "  ...10 ⋯ ...140     ...141 ...142 ...143 ...144   ...145 ...146 ...147\n",
       "1 NA    ⋯ NA         NA     NA     NA     NA       NA     NA     NA    \n",
       "2 NA    ⋯ NA         2023   NA     NA     NA       NA     NA     NA    \n",
       "3 NA    ⋯ 2022 Total Q1     NA     NA     NA       Q2     NA     NA    \n",
       "4 May   ⋯ NA         Jan    Feb    Mar    Q1 Total Apr    May    Jun   \n",
       "5 0     ⋯ 675        220    100    75     390      35     65     40    \n",
       "6 --    ⋯ 90         10     10     15     35       5      --     10    \n",
       "  ...148   ...149    \n",
       "1 NA       NA        \n",
       "2 NA       NA        \n",
       "3 NA       2023 Total\n",
       "4 Q2 Total NA        \n",
       "5 135      530       \n",
       "6 20       55        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "PR_categories <- read_excel(\"/kaggle/input/canada-population-vs-housing-price/PR_categories.xlsx\")\n",
    "head(PR_categories)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f4787b5a",
   "metadata": {
    "papermill": {
     "duration": 0.025756,
     "end_time": "2023-09-06T14:22:34.541944",
     "exception": false,
     "start_time": "2023-09-06T14:22:34.516188",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The issue with this table is that it not raw data, and for represent purpose. Using excel to clean in this case will be easier and faster. Here what I did to have a new data frame serve for the analysis:\n",
    "* Delete the first 2 rows, since it only indicate the period for data collection from Jan 2015 to June 2023\n",
    "* The purpose of this analysis is not about how people get PR in Canada, but about the relationship of immigration on population and house price, so we only need the total number, not detail of each categories, so I deleted them as well, only keep the total number for each month. The total number for the whole year also can be calculated later on R, if needed.\n",
    "* Data frame is better in long, rather than wide, so I copied and transpose to new file.\n",
    "* Using replace to find and replace \" \" in column name to \"_\" to avoid error, and \"--\" to \"0\".\n",
    "* Change last column name from Province/Territory_not_stated to Province_or_Territory_not_stated\n",
    "* The column date consist both month and year, I would like to separate them into 2 by using Data to text function.\n",
    "\n",
    "This is the result\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "29f62e2d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:34.596949Z",
     "iopub.status.busy": "2023-09-06T14:22:34.595216Z",
     "iopub.status.idle": "2023-09-06T14:22:34.683029Z",
     "shell.execute_reply": "2023-09-06T14:22:34.681217Z"
    },
    "papermill": {
     "duration": 0.118147,
     "end_time": "2023-09-06T14:22:34.685672",
     "exception": false,
     "start_time": "2023-09-06T14:22:34.567525",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 16</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>month</th><th scope=col>year</th><th scope=col>Newfoundland_and_Labrador</th><th scope=col>Prince_Edward_Island</th><th scope=col>Nova_Scotia</th><th scope=col>New_Brunswick</th><th scope=col>Quebec</th><th scope=col>Ontario</th><th scope=col>Manitoba</th><th scope=col>Saskatchewan</th><th scope=col>Alberta</th><th scope=col>British_Columbia</th><th scope=col>Yukon</th><th scope=col>Northwest_Territories</th><th scope=col>Nunavut</th><th scope=col>Province_or_Territory_not_stated</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>january </td><td>2015</td><td>50 </td><td>45 </td><td>130</td><td>125</td><td>2,090</td><td>5,320 </td><td>715  </td><td>605  </td><td>1,900</td><td>1,910</td><td>15</td><td>10</td><td>0 </td><td>5</td></tr>\n",
       "\t<tr><td>february</td><td>2015</td><td>75 </td><td>65 </td><td>185</td><td>230</td><td>2,920</td><td>6,590 </td><td>920  </td><td>680  </td><td>2,645</td><td>2,095</td><td>20</td><td>0 </td><td>5 </td><td>0</td></tr>\n",
       "\t<tr><td>march   </td><td>2015</td><td>75 </td><td>90 </td><td>285</td><td>270</td><td>4,205</td><td>7,860 </td><td>1,435</td><td>1,075</td><td>3,660</td><td>2,775</td><td>20</td><td>15</td><td>5 </td><td>0</td></tr>\n",
       "\t<tr><td>april   </td><td>2015</td><td>95 </td><td>75 </td><td>230</td><td>170</td><td>4,070</td><td>7,610 </td><td>1,240</td><td>1,075</td><td>3,785</td><td>2,770</td><td>30</td><td>10</td><td>0 </td><td>0</td></tr>\n",
       "\t<tr><td>may     </td><td>2015</td><td>105</td><td>120</td><td>285</td><td>145</td><td>4,315</td><td>9,510 </td><td>1,260</td><td>1,260</td><td>3,885</td><td>2,970</td><td>15</td><td>25</td><td>0 </td><td>0</td></tr>\n",
       "\t<tr><td>june    </td><td>2015</td><td>70 </td><td>95 </td><td>320</td><td>235</td><td>5,055</td><td>10,575</td><td>1,535</td><td>1,290</td><td>4,295</td><td>3,480</td><td>30</td><td>35</td><td>10</td><td>5</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 16\n",
       "\\begin{tabular}{llllllllllllllll}\n",
       " month & year & Newfoundland\\_and\\_Labrador & Prince\\_Edward\\_Island & Nova\\_Scotia & New\\_Brunswick & Quebec & Ontario & Manitoba & Saskatchewan & Alberta & British\\_Columbia & Yukon & Northwest\\_Territories & Nunavut & Province\\_or\\_Territory\\_not\\_stated\\\\\n",
       " <chr> & <dbl> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t january  & 2015 & 50  & 45  & 130 & 125 & 2,090 & 5,320  & 715   & 605   & 1,900 & 1,910 & 15 & 10 & 0  & 5\\\\\n",
       "\t february & 2015 & 75  & 65  & 185 & 230 & 2,920 & 6,590  & 920   & 680   & 2,645 & 2,095 & 20 & 0  & 5  & 0\\\\\n",
       "\t march    & 2015 & 75  & 90  & 285 & 270 & 4,205 & 7,860  & 1,435 & 1,075 & 3,660 & 2,775 & 20 & 15 & 5  & 0\\\\\n",
       "\t april    & 2015 & 95  & 75  & 230 & 170 & 4,070 & 7,610  & 1,240 & 1,075 & 3,785 & 2,770 & 30 & 10 & 0  & 0\\\\\n",
       "\t may      & 2015 & 105 & 120 & 285 & 145 & 4,315 & 9,510  & 1,260 & 1,260 & 3,885 & 2,970 & 15 & 25 & 0  & 0\\\\\n",
       "\t june     & 2015 & 70  & 95  & 320 & 235 & 5,055 & 10,575 & 1,535 & 1,290 & 4,295 & 3,480 & 30 & 35 & 10 & 5\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 16\n",
       "\n",
       "| month &lt;chr&gt; | year &lt;dbl&gt; | Newfoundland_and_Labrador &lt;chr&gt; | Prince_Edward_Island &lt;chr&gt; | Nova_Scotia &lt;chr&gt; | New_Brunswick &lt;chr&gt; | Quebec &lt;chr&gt; | Ontario &lt;chr&gt; | Manitoba &lt;chr&gt; | Saskatchewan &lt;chr&gt; | Alberta &lt;chr&gt; | British_Columbia &lt;chr&gt; | Yukon &lt;chr&gt; | Northwest_Territories &lt;chr&gt; | Nunavut &lt;chr&gt; | Province_or_Territory_not_stated &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| january  | 2015 | 50  | 45  | 130 | 125 | 2,090 | 5,320  | 715   | 605   | 1,900 | 1,910 | 15 | 10 | 0  | 5 |\n",
       "| february | 2015 | 75  | 65  | 185 | 230 | 2,920 | 6,590  | 920   | 680   | 2,645 | 2,095 | 20 | 0  | 5  | 0 |\n",
       "| march    | 2015 | 75  | 90  | 285 | 270 | 4,205 | 7,860  | 1,435 | 1,075 | 3,660 | 2,775 | 20 | 15 | 5  | 0 |\n",
       "| april    | 2015 | 95  | 75  | 230 | 170 | 4,070 | 7,610  | 1,240 | 1,075 | 3,785 | 2,770 | 30 | 10 | 0  | 0 |\n",
       "| may      | 2015 | 105 | 120 | 285 | 145 | 4,315 | 9,510  | 1,260 | 1,260 | 3,885 | 2,970 | 15 | 25 | 0  | 0 |\n",
       "| june     | 2015 | 70  | 95  | 320 | 235 | 5,055 | 10,575 | 1,535 | 1,290 | 4,295 | 3,480 | 30 | 35 | 10 | 5 |\n",
       "\n"
      ],
      "text/plain": [
       "  month    year Newfoundland_and_Labrador Prince_Edward_Island Nova_Scotia\n",
       "1 january  2015 50                        45                   130        \n",
       "2 february 2015 75                        65                   185        \n",
       "3 march    2015 75                        90                   285        \n",
       "4 april    2015 95                        75                   230        \n",
       "5 may      2015 105                       120                  285        \n",
       "6 june     2015 70                        95                   320        \n",
       "  New_Brunswick Quebec Ontario Manitoba Saskatchewan Alberta British_Columbia\n",
       "1 125           2,090  5,320   715      605          1,900   1,910           \n",
       "2 230           2,920  6,590   920      680          2,645   2,095           \n",
       "3 270           4,205  7,860   1,435    1,075        3,660   2,775           \n",
       "4 170           4,070  7,610   1,240    1,075        3,785   2,770           \n",
       "5 145           4,315  9,510   1,260    1,260        3,885   2,970           \n",
       "6 235           5,055  10,575  1,535    1,290        4,295   3,480           \n",
       "  Yukon Northwest_Territories Nunavut Province_or_Territory_not_stated\n",
       "1 15    10                    0       5                               \n",
       "2 20    0                     5       0                               \n",
       "3 20    15                    5       0                               \n",
       "4 30    10                    0       0                               \n",
       "5 15    25                    0       0                               \n",
       "6 30    35                    10      5                               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "regional_PR <- read_excel(\"/kaggle/input/canada-population-vs-housing-price/regional_PR.xlsx\")\n",
    "head(regional_PR)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ade77459",
   "metadata": {
    "papermill": {
     "duration": 0.025855,
     "end_time": "2023-09-06T14:22:34.738374",
     "exception": false,
     "start_time": "2023-09-06T14:22:34.712519",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Study permit holders by regions\n",
    "\n",
    "Similar with PR data, this is a xlxs file, it easier and faster to clean on excel.\n",
    "* First we delete the first 2 rows where it state the period is from 2000 to 2022.\n",
    "* Then delete the study permit categories, and the total\n",
    "* Replace \" \" with \"_\"\n",
    "* Replace \"/\" with \"_or_\"\n",
    "* Replace \"--\" with \"0\"\n",
    "* Copy the table and transpose\n",
    "* Name the first column \"date\"\n",
    "\n",
    "Here the result:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "75eb24b7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:34.794797Z",
     "iopub.status.busy": "2023-09-06T14:22:34.792989Z",
     "iopub.status.idle": "2023-09-06T14:22:34.869745Z",
     "shell.execute_reply": "2023-09-06T14:22:34.867859Z"
    },
    "papermill": {
     "duration": 0.108059,
     "end_time": "2023-09-06T14:22:34.872439",
     "exception": false,
     "start_time": "2023-09-06T14:22:34.764380",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Date</th><th scope=col>Newfoundland_and_Labrador</th><th scope=col>Prince_Edward_Island</th><th scope=col>Nova_Scotia</th><th scope=col>New_Brunswick</th><th scope=col>Quebec</th><th scope=col>Ontario</th><th scope=col>Manitoba</th><th scope=col>Saskatchewan</th><th scope=col>Alberta</th><th scope=col>British_Columbia</th><th scope=col>Northwest_Territories</th><th scope=col>Yukon</th><th scope=col>Nunavut</th><th scope=col>Province_or_Territory_not_stated</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2000</td><td> 690</td><td>235</td><td>3075</td><td>1825</td><td>22775</td><td>46140</td><td>2830</td><td>2690</td><td> 9435</td><td>32895</td><td>25</td><td>45</td><td> 0</td><td>0</td></tr>\n",
       "\t<tr><td>2001</td><td> 725</td><td>255</td><td>3685</td><td>2305</td><td>25095</td><td>55790</td><td>3205</td><td>3055</td><td>10645</td><td>41125</td><td>30</td><td>25</td><td> 0</td><td>0</td></tr>\n",
       "\t<tr><td>2002</td><td> 785</td><td>260</td><td>4400</td><td>2775</td><td>24915</td><td>62590</td><td>3720</td><td>3270</td><td>11070</td><td>44255</td><td>30</td><td>50</td><td> 5</td><td>0</td></tr>\n",
       "\t<tr><td>2003</td><td> 895</td><td>285</td><td>5095</td><td>3025</td><td>25205</td><td>64110</td><td>4250</td><td>3520</td><td>11585</td><td>46410</td><td>55</td><td>30</td><td> 5</td><td>0</td></tr>\n",
       "\t<tr><td>2004</td><td> 910</td><td>315</td><td>5430</td><td>3200</td><td>25605</td><td>65495</td><td>4710</td><td>3560</td><td>11760</td><td>47515</td><td>50</td><td>35</td><td>10</td><td>0</td></tr>\n",
       "\t<tr><td>2005</td><td>1075</td><td>345</td><td>5425</td><td>3225</td><td>25610</td><td>64625</td><td>4955</td><td>3690</td><td>12205</td><td>49190</td><td>60</td><td>30</td><td> 5</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 15\n",
       "\\begin{tabular}{lllllllllllllll}\n",
       " Date & Newfoundland\\_and\\_Labrador & Prince\\_Edward\\_Island & Nova\\_Scotia & New\\_Brunswick & Quebec & Ontario & Manitoba & Saskatchewan & Alberta & British\\_Columbia & Northwest\\_Territories & Yukon & Nunavut & Province\\_or\\_Territory\\_not\\_stated\\\\\n",
       " <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2000 &  690 & 235 & 3075 & 1825 & 22775 & 46140 & 2830 & 2690 &  9435 & 32895 & 25 & 45 &  0 & 0\\\\\n",
       "\t 2001 &  725 & 255 & 3685 & 2305 & 25095 & 55790 & 3205 & 3055 & 10645 & 41125 & 30 & 25 &  0 & 0\\\\\n",
       "\t 2002 &  785 & 260 & 4400 & 2775 & 24915 & 62590 & 3720 & 3270 & 11070 & 44255 & 30 & 50 &  5 & 0\\\\\n",
       "\t 2003 &  895 & 285 & 5095 & 3025 & 25205 & 64110 & 4250 & 3520 & 11585 & 46410 & 55 & 30 &  5 & 0\\\\\n",
       "\t 2004 &  910 & 315 & 5430 & 3200 & 25605 & 65495 & 4710 & 3560 & 11760 & 47515 & 50 & 35 & 10 & 0\\\\\n",
       "\t 2005 & 1075 & 345 & 5425 & 3225 & 25610 & 64625 & 4955 & 3690 & 12205 & 49190 & 60 & 30 &  5 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 15\n",
       "\n",
       "| Date &lt;dbl&gt; | Newfoundland_and_Labrador &lt;dbl&gt; | Prince_Edward_Island &lt;dbl&gt; | Nova_Scotia &lt;dbl&gt; | New_Brunswick &lt;dbl&gt; | Quebec &lt;dbl&gt; | Ontario &lt;dbl&gt; | Manitoba &lt;dbl&gt; | Saskatchewan &lt;dbl&gt; | Alberta &lt;dbl&gt; | British_Columbia &lt;dbl&gt; | Northwest_Territories &lt;dbl&gt; | Yukon &lt;dbl&gt; | Nunavut &lt;dbl&gt; | Province_or_Territory_not_stated &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2000 |  690 | 235 | 3075 | 1825 | 22775 | 46140 | 2830 | 2690 |  9435 | 32895 | 25 | 45 |  0 | 0 |\n",
       "| 2001 |  725 | 255 | 3685 | 2305 | 25095 | 55790 | 3205 | 3055 | 10645 | 41125 | 30 | 25 |  0 | 0 |\n",
       "| 2002 |  785 | 260 | 4400 | 2775 | 24915 | 62590 | 3720 | 3270 | 11070 | 44255 | 30 | 50 |  5 | 0 |\n",
       "| 2003 |  895 | 285 | 5095 | 3025 | 25205 | 64110 | 4250 | 3520 | 11585 | 46410 | 55 | 30 |  5 | 0 |\n",
       "| 2004 |  910 | 315 | 5430 | 3200 | 25605 | 65495 | 4710 | 3560 | 11760 | 47515 | 50 | 35 | 10 | 0 |\n",
       "| 2005 | 1075 | 345 | 5425 | 3225 | 25610 | 64625 | 4955 | 3690 | 12205 | 49190 | 60 | 30 |  5 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  Date Newfoundland_and_Labrador Prince_Edward_Island Nova_Scotia New_Brunswick\n",
       "1 2000  690                      235                  3075        1825         \n",
       "2 2001  725                      255                  3685        2305         \n",
       "3 2002  785                      260                  4400        2775         \n",
       "4 2003  895                      285                  5095        3025         \n",
       "5 2004  910                      315                  5430        3200         \n",
       "6 2005 1075                      345                  5425        3225         \n",
       "  Quebec Ontario Manitoba Saskatchewan Alberta British_Columbia\n",
       "1 22775  46140   2830     2690          9435   32895           \n",
       "2 25095  55790   3205     3055         10645   41125           \n",
       "3 24915  62590   3720     3270         11070   44255           \n",
       "4 25205  64110   4250     3520         11585   46410           \n",
       "5 25605  65495   4710     3560         11760   47515           \n",
       "6 25610  64625   4955     3690         12205   49190           \n",
       "  Northwest_Territories Yukon Nunavut Province_or_Territory_not_stated\n",
       "1 25                    45     0      0                               \n",
       "2 30                    25     0      0                               \n",
       "3 30                    50     5      0                               \n",
       "4 55                    30     5      0                               \n",
       "5 50                    35    10      0                               \n",
       "6 60                    30     5      0                               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "regional_study_permit <- read_excel(\"/kaggle/input/canada-population-vs-housing-price/regional_study_permit.xlsx\")\n",
    "head(regional_study_permit)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b9af97d2",
   "metadata": {
    "papermill": {
     "duration": 0.02638,
     "end_time": "2023-09-06T14:22:34.925186",
     "exception": false,
     "start_time": "2023-09-06T14:22:34.898806",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Work permit(WP) holders\n",
    "\n",
    "We follow the same steps as with study permit holder to have below result:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "1977dd1c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:34.989457Z",
     "iopub.status.busy": "2023-09-06T14:22:34.987516Z",
     "iopub.status.idle": "2023-09-06T14:22:35.071106Z",
     "shell.execute_reply": "2023-09-06T14:22:35.068508Z"
    },
    "papermill": {
     "duration": 0.121939,
     "end_time": "2023-09-06T14:22:35.074395",
     "exception": false,
     "start_time": "2023-09-06T14:22:34.952456",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>date</th><th scope=col>Newfoundland_and_Labrador</th><th scope=col>Prince_Edward_Island</th><th scope=col>Nova_Scotia</th><th scope=col>New_Brunswick</th><th scope=col>Quebec</th><th scope=col>Ontario</th><th scope=col>Manitoba</th><th scope=col>Saskatchewan</th><th scope=col>Alberta</th><th scope=col>British_Columbia</th><th scope=col>Yukon</th><th scope=col>Northwest_Territories</th><th scope=col>Nunavut</th><th scope=col>Province_or_Territory_not_stated</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2000</td><td>565</td><td>45</td><td>390</td><td>190</td><td>2930</td><td> 9005</td><td> 640</td><td>555</td><td>3480</td><td>4550</td><td>20</td><td> 90</td><td>10</td><td>5</td></tr>\n",
       "\t<tr><td>2001</td><td>490</td><td>50</td><td>665</td><td>185</td><td>3450</td><td>10570</td><td> 765</td><td>625</td><td>3960</td><td>5225</td><td>15</td><td>130</td><td>10</td><td>0</td></tr>\n",
       "\t<tr><td>2002</td><td>480</td><td>60</td><td>500</td><td>180</td><td>3770</td><td>12485</td><td> 960</td><td>675</td><td>4190</td><td>5745</td><td>30</td><td>130</td><td>15</td><td>0</td></tr>\n",
       "\t<tr><td>2003</td><td>565</td><td>65</td><td>510</td><td>225</td><td>4260</td><td>14925</td><td>1050</td><td>710</td><td>4550</td><td>6900</td><td>40</td><td>145</td><td>20</td><td>0</td></tr>\n",
       "\t<tr><td>2004</td><td>460</td><td>55</td><td>580</td><td>300</td><td>4625</td><td>16625</td><td>1065</td><td>755</td><td>4795</td><td>7705</td><td>35</td><td>140</td><td>15</td><td>0</td></tr>\n",
       "\t<tr><td>2005</td><td>485</td><td>45</td><td>530</td><td>315</td><td>5485</td><td>19165</td><td>1180</td><td>835</td><td>5970</td><td>9130</td><td>50</td><td>125</td><td>35</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 15\n",
       "\\begin{tabular}{lllllllllllllll}\n",
       " date & Newfoundland\\_and\\_Labrador & Prince\\_Edward\\_Island & Nova\\_Scotia & New\\_Brunswick & Quebec & Ontario & Manitoba & Saskatchewan & Alberta & British\\_Columbia & Yukon & Northwest\\_Territories & Nunavut & Province\\_or\\_Territory\\_not\\_stated\\\\\n",
       " <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2000 & 565 & 45 & 390 & 190 & 2930 &  9005 &  640 & 555 & 3480 & 4550 & 20 &  90 & 10 & 5\\\\\n",
       "\t 2001 & 490 & 50 & 665 & 185 & 3450 & 10570 &  765 & 625 & 3960 & 5225 & 15 & 130 & 10 & 0\\\\\n",
       "\t 2002 & 480 & 60 & 500 & 180 & 3770 & 12485 &  960 & 675 & 4190 & 5745 & 30 & 130 & 15 & 0\\\\\n",
       "\t 2003 & 565 & 65 & 510 & 225 & 4260 & 14925 & 1050 & 710 & 4550 & 6900 & 40 & 145 & 20 & 0\\\\\n",
       "\t 2004 & 460 & 55 & 580 & 300 & 4625 & 16625 & 1065 & 755 & 4795 & 7705 & 35 & 140 & 15 & 0\\\\\n",
       "\t 2005 & 485 & 45 & 530 & 315 & 5485 & 19165 & 1180 & 835 & 5970 & 9130 & 50 & 125 & 35 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 15\n",
       "\n",
       "| date &lt;dbl&gt; | Newfoundland_and_Labrador &lt;dbl&gt; | Prince_Edward_Island &lt;dbl&gt; | Nova_Scotia &lt;dbl&gt; | New_Brunswick &lt;dbl&gt; | Quebec &lt;dbl&gt; | Ontario &lt;dbl&gt; | Manitoba &lt;dbl&gt; | Saskatchewan &lt;dbl&gt; | Alberta &lt;dbl&gt; | British_Columbia &lt;dbl&gt; | Yukon &lt;dbl&gt; | Northwest_Territories &lt;dbl&gt; | Nunavut &lt;dbl&gt; | Province_or_Territory_not_stated &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2000 | 565 | 45 | 390 | 190 | 2930 |  9005 |  640 | 555 | 3480 | 4550 | 20 |  90 | 10 | 5 |\n",
       "| 2001 | 490 | 50 | 665 | 185 | 3450 | 10570 |  765 | 625 | 3960 | 5225 | 15 | 130 | 10 | 0 |\n",
       "| 2002 | 480 | 60 | 500 | 180 | 3770 | 12485 |  960 | 675 | 4190 | 5745 | 30 | 130 | 15 | 0 |\n",
       "| 2003 | 565 | 65 | 510 | 225 | 4260 | 14925 | 1050 | 710 | 4550 | 6900 | 40 | 145 | 20 | 0 |\n",
       "| 2004 | 460 | 55 | 580 | 300 | 4625 | 16625 | 1065 | 755 | 4795 | 7705 | 35 | 140 | 15 | 0 |\n",
       "| 2005 | 485 | 45 | 530 | 315 | 5485 | 19165 | 1180 | 835 | 5970 | 9130 | 50 | 125 | 35 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  date Newfoundland_and_Labrador Prince_Edward_Island Nova_Scotia New_Brunswick\n",
       "1 2000 565                       45                   390         190          \n",
       "2 2001 490                       50                   665         185          \n",
       "3 2002 480                       60                   500         180          \n",
       "4 2003 565                       65                   510         225          \n",
       "5 2004 460                       55                   580         300          \n",
       "6 2005 485                       45                   530         315          \n",
       "  Quebec Ontario Manitoba Saskatchewan Alberta British_Columbia Yukon\n",
       "1 2930    9005    640     555          3480    4550             20   \n",
       "2 3450   10570    765     625          3960    5225             15   \n",
       "3 3770   12485    960     675          4190    5745             30   \n",
       "4 4260   14925   1050     710          4550    6900             40   \n",
       "5 4625   16625   1065     755          4795    7705             35   \n",
       "6 5485   19165   1180     835          5970    9130             50   \n",
       "  Northwest_Territories Nunavut Province_or_Territory_not_stated\n",
       "1  90                   10      5                               \n",
       "2 130                   10      0                               \n",
       "3 130                   15      0                               \n",
       "4 145                   20      0                               \n",
       "5 140                   15      0                               \n",
       "6 125                   35      0                               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "regional_WP <- read_excel(\"/kaggle/input/canada-population-vs-housing-price/regional_WP.xlsx\")\n",
    "head(regional_WP)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2fff94cd",
   "metadata": {
    "papermill": {
     "duration": 0.027669,
     "end_time": "2023-09-06T14:22:35.128915",
     "exception": false,
     "start_time": "2023-09-06T14:22:35.101246",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Analysing\n",
    "## Relationship between population and immigration\n",
    "### Canadian population growth rate\n",
    "Since this is a small dataset, I can do calculation on excel. I would like to see the the different between growth rate in Canada, compare with the world average. These are the step I did:\n",
    "* Add another row for the World\n",
    "* Using formula \"average\" for the value\n",
    "* Transpose into new excel file called \"growth_rate_comparison.xlsx\"\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "0bc3a317",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:35.186587Z",
     "iopub.status.busy": "2023-09-06T14:22:35.184862Z",
     "iopub.status.idle": "2023-09-06T14:22:35.235831Z",
     "shell.execute_reply": "2023-09-06T14:22:35.233490Z"
    },
    "papermill": {
     "duration": 0.082876,
     "end_time": "2023-09-06T14:22:35.238686",
     "exception": false,
     "start_time": "2023-09-06T14:22:35.155810",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 62\n",
      "Columns: 3\n",
      "$ year      \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, …\n",
      "$ the_World \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 2.194694, 2.286454, 2.359061, 2.304018, 2.290890, 2.252961, …\n",
      "$ Canada    \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1.9991846, 1.8598882, 1.8628459, 1.8857149, 1.8101666, 1.862…\n"
     ]
    }
   ],
   "source": [
    "growth_rate_comparison <- read_excel(\"/kaggle/input/canada-population-vs-housing-price/growth_rate_comparison.xlsx\")\n",
    "glimpse(growth_rate_comparison)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "ccd1f096",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:35.297453Z",
     "iopub.status.busy": "2023-09-06T14:22:35.295554Z",
     "iopub.status.idle": "2023-09-06T14:22:35.997767Z",
     "shell.execute_reply": "2023-09-06T14:22:35.994655Z"
    },
    "papermill": {
     "duration": 0.735452,
     "end_time": "2023-09-06T14:22:36.001662",
     "exception": false,
     "start_time": "2023-09-06T14:22:35.266210",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdd3wT9R8G8Oeyuyd7771UQLaKKCCoCMjwx3CgIgooKEsUZYMiQxFFVAQFFLeC\nggtQtigqG8oS2V20TdIkd78/UppcmnFt04z2ef/Bi/vmcvk0o3n6ufveCZIkgYiIiIjCnyrY\nBRARERGRfzDYEREREZUSDHZEREREpQSDHREREVEpwWBHREREVEow2BERERGVEgx2RERERKUE\ngx0RERFRKRHGwW73080EBe7ef/nYys6CIHReeczvNZz+prsgCNrIemKBm7YNrS8Igjaybm6B\nM0DvGNlYEITYauOL+eh/zW0tCELXL095X+21OgmCIGxIMxXz4QJM4U/n3e+TWgqC0GPLf34q\nKuyV3GehmCTbtS+Wvtz/jpurVUyO0OriEsu36njnxAWrr1gKfraCL0w/U0RUFmiCXUDRGZKr\n163r+MUqidknUs4LgqZOnZrOq1XSq0uuhgrtnwS+txqPf3rF2D85wvmmpd+dA2A1nnj9v6xn\nqkQ737RxwzkA1fv0L7nCyiZJzN6+40+Nvnrbm6oFu5aQEC5PSPa5n/p0vHfzqWsA9DFJFatU\nSL94/s/fNv3526alS97/bu837ZMMwa6RiCg8hHHHrvmUb485+WfvOwBU2nLH5N5qmFhyNRgS\ne90cqwfw3u9XnMctWXvWXTHa/79mVYrzTZJofPN8NoDOj9crucLKJqvxaMeOHe/ouzx/pGb/\n6e+///64hglBrCqICj4hIchqPHJn07s2n7pW45aHNuw6Zsq8curU2fTsa3/9uKZPs8Rrp37s\n2eYJMy98SESkTBgHuxAxvkUSgIOvH3YevLRntiRJNfreD+DYW58735Rz8b0rFpug0k2oExfI\nOsumpBt6Dxs27PYKEb5XpSBZeV+339JNVbu/dPjHFT3a1M0bVUU0u23gJ3v+7BKnz0h571Hu\nTCciUobBrrhuGt8UwJXdK50H983eC6DfrCV1IjTXzr5yPtdxnNDFbZ8AiKr4SI3i7COWzJdK\n5tgjMddk81N3xI+bCiox22Qtwc2X2EsZFkypX4/8/l+1rtLX6ycZCvw2UuurvTamMYDvxm0u\n6iOU8MtHRBRiylawu3Zi8yN9OldIitUaomo26zB56fcF1zn960fD772lSvkEfWR8vWatn3hp\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(data = growth_rate_comparison)+\n",
    "  geom_line(aes(x = year, y = the_World, color = \"World\"), linewidth = 1) + \n",
    "  geom_line(aes(x = year, y = Canada, color = \"Canada\"), linewidth = 1) +\n",
    "  labs(x = \"Year\", y = \"Growth rate\", title = \"The World population growth vs Canada\") + \n",
    "  scale_color_manual(values = c(\"World\" = \"blue\", \"Canada\" = \"red\")) +\n",
    "  labs(color = \" \") +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "277baa4c",
   "metadata": {
    "papermill": {
     "duration": 0.028244,
     "end_time": "2023-09-06T14:22:36.101128",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.072884",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Comparing with the World average, the growth rate of Canada significantly increased, and went in opposite direction from 2020 till now.\n",
    "\n",
    "### Relationship between immigration and population\n",
    "Although work permit holder and study permit holders are not Canadian, but they are deemed to be temporary residents, therefore, they are counted in population as well.\n",
    "\n",
    "First we need to modify all data frame into the same format.\n",
    "With the ca_population REF_DATE column is in format \"mmm-yy\", and the population was recorded in January, April, July, and Octorber, I will use the lastest time, which is Octorber to represent that year population. To do this  we need to change REF_DATE column to date type\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "b183e2e1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:36.161405Z",
     "iopub.status.busy": "2023-09-06T14:22:36.159641Z",
     "iopub.status.idle": "2023-09-06T14:22:36.195567Z",
     "shell.execute_reply": "2023-09-06T14:22:36.193603Z"
    },
    "papermill": {
     "duration": 0.069727,
     "end_time": "2023-09-06T14:22:36.199013",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.129286",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "ca_population <- ca_population %>%\n",
    "  mutate(\n",
    "    REF_DATE = as.Date(paste0(\"20\", substring(REF_DATE, 5, 6), \"-\", substring(REF_DATE, 1, 3), \"-01\"), format = \"%Y-%b-%d\"),\n",
    "    year = lubridate::year(REF_DATE),\n",
    "    month = lubridate::month(REF_DATE)\n",
    "  )"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "f3348237",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:36.260167Z",
     "iopub.status.busy": "2023-09-06T14:22:36.258461Z",
     "iopub.status.idle": "2023-09-06T14:22:36.320888Z",
     "shell.execute_reply": "2023-09-06T14:22:36.318287Z"
    },
    "papermill": {
     "duration": 0.096437,
     "end_time": "2023-09-06T14:22:36.324210",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.227773",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 16</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>REF_DATE</th><th scope=col>GEO</th><th scope=col>DGUID</th><th scope=col>UOM</th><th scope=col>UOM_ID</th><th scope=col>SCALAR_FACTOR</th><th scope=col>SCALAR_ID</th><th scope=col>VECTOR</th><th scope=col>COORDINATE</th><th scope=col>VALUE</th><th scope=col>STATUS</th><th scope=col>SYMBOL</th><th scope=col>TERMINATED</th><th scope=col>DECIMALS</th><th scope=col>year</th><th scope=col>month</th></tr>\n",
       "\t<tr><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2046-01-01</td><td>Canada</td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1</td><td>1</td><td>12188000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td><td>2046</td><td> 1</td></tr>\n",
       "\t<tr><td>2046-04-01</td><td>Canada</td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1</td><td>1</td><td>12241000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td><td>2046</td><td> 4</td></tr>\n",
       "\t<tr><td>2046-07-01</td><td>Canada</td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1</td><td>1</td><td>12316000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td><td>2046</td><td> 7</td></tr>\n",
       "\t<tr><td>2046-10-01</td><td>Canada</td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1</td><td>1</td><td>12393000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td><td>2046</td><td>10</td></tr>\n",
       "\t<tr><td>2047-01-01</td><td>Canada</td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1</td><td>1</td><td>12450000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td><td>2047</td><td> 1</td></tr>\n",
       "\t<tr><td>2047-04-01</td><td>Canada</td><td>2016A000011124</td><td>Persons</td><td>249</td><td>units</td><td>0</td><td>v1</td><td>1</td><td>12507000</td><td>NA</td><td>NA</td><td>NA</td><td>0</td><td>2047</td><td> 4</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 16\n",
       "\\begin{tabular}{llllllllllllllll}\n",
       " REF\\_DATE & GEO & DGUID & UOM & UOM\\_ID & SCALAR\\_FACTOR & SCALAR\\_ID & VECTOR & COORDINATE & VALUE & STATUS & SYMBOL & TERMINATED & DECIMALS & year & month\\\\\n",
       " <date> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <lgl> & <lgl> & <lgl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2046-01-01 & Canada & 2016A000011124 & Persons & 249 & units & 0 & v1 & 1 & 12188000 & NA & NA & NA & 0 & 2046 &  1\\\\\n",
       "\t 2046-04-01 & Canada & 2016A000011124 & Persons & 249 & units & 0 & v1 & 1 & 12241000 & NA & NA & NA & 0 & 2046 &  4\\\\\n",
       "\t 2046-07-01 & Canada & 2016A000011124 & Persons & 249 & units & 0 & v1 & 1 & 12316000 & NA & NA & NA & 0 & 2046 &  7\\\\\n",
       "\t 2046-10-01 & Canada & 2016A000011124 & Persons & 249 & units & 0 & v1 & 1 & 12393000 & NA & NA & NA & 0 & 2046 & 10\\\\\n",
       "\t 2047-01-01 & Canada & 2016A000011124 & Persons & 249 & units & 0 & v1 & 1 & 12450000 & NA & NA & NA & 0 & 2047 &  1\\\\\n",
       "\t 2047-04-01 & Canada & 2016A000011124 & Persons & 249 & units & 0 & v1 & 1 & 12507000 & NA & NA & NA & 0 & 2047 &  4\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 16\n",
       "\n",
       "| REF_DATE &lt;date&gt; | GEO &lt;chr&gt; | DGUID &lt;chr&gt; | UOM &lt;chr&gt; | UOM_ID &lt;dbl&gt; | SCALAR_FACTOR &lt;chr&gt; | SCALAR_ID &lt;dbl&gt; | VECTOR &lt;chr&gt; | COORDINATE &lt;dbl&gt; | VALUE &lt;dbl&gt; | STATUS &lt;lgl&gt; | SYMBOL &lt;lgl&gt; | TERMINATED &lt;lgl&gt; | DECIMALS &lt;dbl&gt; | year &lt;dbl&gt; | month &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2046-01-01 | Canada | 2016A000011124 | Persons | 249 | units | 0 | v1 | 1 | 12188000 | NA | NA | NA | 0 | 2046 |  1 |\n",
       "| 2046-04-01 | Canada | 2016A000011124 | Persons | 249 | units | 0 | v1 | 1 | 12241000 | NA | NA | NA | 0 | 2046 |  4 |\n",
       "| 2046-07-01 | Canada | 2016A000011124 | Persons | 249 | units | 0 | v1 | 1 | 12316000 | NA | NA | NA | 0 | 2046 |  7 |\n",
       "| 2046-10-01 | Canada | 2016A000011124 | Persons | 249 | units | 0 | v1 | 1 | 12393000 | NA | NA | NA | 0 | 2046 | 10 |\n",
       "| 2047-01-01 | Canada | 2016A000011124 | Persons | 249 | units | 0 | v1 | 1 | 12450000 | NA | NA | NA | 0 | 2047 |  1 |\n",
       "| 2047-04-01 | Canada | 2016A000011124 | Persons | 249 | units | 0 | v1 | 1 | 12507000 | NA | NA | NA | 0 | 2047 |  4 |\n",
       "\n"
      ],
      "text/plain": [
       "  REF_DATE   GEO    DGUID          UOM     UOM_ID SCALAR_FACTOR SCALAR_ID\n",
       "1 2046-01-01 Canada 2016A000011124 Persons 249    units         0        \n",
       "2 2046-04-01 Canada 2016A000011124 Persons 249    units         0        \n",
       "3 2046-07-01 Canada 2016A000011124 Persons 249    units         0        \n",
       "4 2046-10-01 Canada 2016A000011124 Persons 249    units         0        \n",
       "5 2047-01-01 Canada 2016A000011124 Persons 249    units         0        \n",
       "6 2047-04-01 Canada 2016A000011124 Persons 249    units         0        \n",
       "  VECTOR COORDINATE VALUE    STATUS SYMBOL TERMINATED DECIMALS year month\n",
       "1 v1     1          12188000 NA     NA     NA         0        2046  1   \n",
       "2 v1     1          12241000 NA     NA     NA         0        2046  4   \n",
       "3 v1     1          12316000 NA     NA     NA         0        2046  7   \n",
       "4 v1     1          12393000 NA     NA     NA         0        2046 10   \n",
       "5 v1     1          12450000 NA     NA     NA         0        2047  1   \n",
       "6 v1     1          12507000 NA     NA     NA         0        2047  4   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(ca_population)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "938d889d",
   "metadata": {
    "papermill": {
     "duration": 0.028529,
     "end_time": "2023-09-06T14:22:36.381491",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.352962",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Then we will filter out the population recored in Octorber\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "9c281eeb",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:36.442755Z",
     "iopub.status.busy": "2023-09-06T14:22:36.440923Z",
     "iopub.status.idle": "2023-09-06T14:22:36.481981Z",
     "shell.execute_reply": "2023-09-06T14:22:36.479971Z"
    },
    "papermill": {
     "duration": 0.076166,
     "end_time": "2023-09-06T14:22:36.486067",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.409901",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "yearly_population <- ca_population %>%\n",
    "  filter(month(REF_DATE) == 10) %>%\n",
    "  group_by(year = year(REF_DATE)) %>% \n",
    "  select(year, GEO,VALUE) %>% \n",
    "  rename(\"population\" = VALUE, regions = GEO)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "8f41d0ff",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:36.547919Z",
     "iopub.status.busy": "2023-09-06T14:22:36.546101Z",
     "iopub.status.idle": "2023-09-06T14:22:36.579323Z",
     "shell.execute_reply": "2023-09-06T14:22:36.577314Z"
    },
    "papermill": {
     "duration": 0.067069,
     "end_time": "2023-09-06T14:22:36.582017",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.514948",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>year</th><th scope=col>regions</th><th scope=col>population</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2046</td><td>Canada</td><td>12393000</td></tr>\n",
       "\t<tr><td>2047</td><td>Canada</td><td>12646000</td></tr>\n",
       "\t<tr><td>2048</td><td>Canada</td><td>12930000</td></tr>\n",
       "\t<tr><td>2049</td><td>Canada</td><td>13548000</td></tr>\n",
       "\t<tr><td>2050</td><td>Canada</td><td>13807000</td></tr>\n",
       "\t<tr><td>2051</td><td>Canada</td><td>14163000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " year & regions & population\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2046 & Canada & 12393000\\\\\n",
       "\t 2047 & Canada & 12646000\\\\\n",
       "\t 2048 & Canada & 12930000\\\\\n",
       "\t 2049 & Canada & 13548000\\\\\n",
       "\t 2050 & Canada & 13807000\\\\\n",
       "\t 2051 & Canada & 14163000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| year &lt;dbl&gt; | regions &lt;chr&gt; | population &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2046 | Canada | 12393000 |\n",
       "| 2047 | Canada | 12646000 |\n",
       "| 2048 | Canada | 12930000 |\n",
       "| 2049 | Canada | 13548000 |\n",
       "| 2050 | Canada | 13807000 |\n",
       "| 2051 | Canada | 14163000 |\n",
       "\n"
      ],
      "text/plain": [
       "  year regions population\n",
       "1 2046 Canada  12393000  \n",
       "2 2047 Canada  12646000  \n",
       "3 2048 Canada  12930000  \n",
       "4 2049 Canada  13548000  \n",
       "5 2050 Canada  13807000  \n",
       "6 2051 Canada  14163000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(yearly_population)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8762e745",
   "metadata": {
    "papermill": {
     "duration": 0.029004,
     "end_time": "2023-09-06T14:22:36.642206",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.613202",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Next, we change regional_study permit to the same format as \"yearly_population\"\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "faaf7706",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:36.707605Z",
     "iopub.status.busy": "2023-09-06T14:22:36.705849Z",
     "iopub.status.idle": "2023-09-06T14:22:36.755029Z",
     "shell.execute_reply": "2023-09-06T14:22:36.753060Z"
    },
    "papermill": {
     "duration": 0.084718,
     "end_time": "2023-09-06T14:22:36.758892",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.674174",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "study_permit_long <- regional_study_permit %>% \n",
    "  select(Newfoundland_and_Labrador, \n",
    "         Prince_Edward_Island, \n",
    "         Nova_Scotia, \n",
    "         New_Brunswick, \n",
    "         Quebec, \n",
    "         Ontario, \n",
    "         Manitoba,\n",
    "         Saskatchewan,\n",
    "         Alberta,\n",
    "         British_Columbia,\n",
    "         Northwest_Territories,\n",
    "         Yukon,\n",
    "         Nunavut,\n",
    "         Province_or_Territory_not_stated,\n",
    "         Date\n",
    "         ) %>% \n",
    "  pivot_longer(cols = c(Newfoundland_and_Labrador, \n",
    "                       Prince_Edward_Island, \n",
    "                       Nova_Scotia, \n",
    "                       New_Brunswick, \n",
    "                       Quebec, \n",
    "                       Ontario, \n",
    "                       Manitoba,\n",
    "                       Saskatchewan,\n",
    "                       Alberta,\n",
    "                       British_Columbia,\n",
    "                       Northwest_Territories,\n",
    "                       Yukon,\n",
    "                       Nunavut,\n",
    "                       Province_or_Territory_not_stated),\n",
    "               names_to = \"regions\", values_to = \"study_permit_holder\")%>% \n",
    "  rename(year = Date)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "e18be427",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:36.820980Z",
     "iopub.status.busy": "2023-09-06T14:22:36.819255Z",
     "iopub.status.idle": "2023-09-06T14:22:36.858242Z",
     "shell.execute_reply": "2023-09-06T14:22:36.855682Z"
    },
    "papermill": {
     "duration": 0.07359,
     "end_time": "2023-09-06T14:22:36.861390",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.787800",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>year</th><th scope=col>regions</th><th scope=col>study_permit_holder</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2000</td><td>Newfoundland_and_Labrador</td><td>  690</td></tr>\n",
       "\t<tr><td>2000</td><td>Prince_Edward_Island     </td><td>  235</td></tr>\n",
       "\t<tr><td>2000</td><td>Nova_Scotia              </td><td> 3075</td></tr>\n",
       "\t<tr><td>2000</td><td>New_Brunswick            </td><td> 1825</td></tr>\n",
       "\t<tr><td>2000</td><td>Quebec                   </td><td>22775</td></tr>\n",
       "\t<tr><td>2000</td><td>Ontario                  </td><td>46140</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " year & regions & study\\_permit\\_holder\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2000 & Newfoundland\\_and\\_Labrador &   690\\\\\n",
       "\t 2000 & Prince\\_Edward\\_Island      &   235\\\\\n",
       "\t 2000 & Nova\\_Scotia               &  3075\\\\\n",
       "\t 2000 & New\\_Brunswick             &  1825\\\\\n",
       "\t 2000 & Quebec                    & 22775\\\\\n",
       "\t 2000 & Ontario                   & 46140\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 3\n",
       "\n",
       "| year &lt;dbl&gt; | regions &lt;chr&gt; | study_permit_holder &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2000 | Newfoundland_and_Labrador |   690 |\n",
       "| 2000 | Prince_Edward_Island      |   235 |\n",
       "| 2000 | Nova_Scotia               |  3075 |\n",
       "| 2000 | New_Brunswick             |  1825 |\n",
       "| 2000 | Quebec                    | 22775 |\n",
       "| 2000 | Ontario                   | 46140 |\n",
       "\n"
      ],
      "text/plain": [
       "  year regions                   study_permit_holder\n",
       "1 2000 Newfoundland_and_Labrador   690              \n",
       "2 2000 Prince_Edward_Island        235              \n",
       "3 2000 Nova_Scotia                3075              \n",
       "4 2000 New_Brunswick              1825              \n",
       "5 2000 Quebec                    22775              \n",
       "6 2000 Ontario                   46140              "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(study_permit_long)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9ff9ddb3",
   "metadata": {
    "papermill": {
     "duration": 0.029474,
     "end_time": "2023-09-06T14:22:36.919984",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.890510",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Similarly done for Work permit holder and PR holders\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "3f328a62",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:36.982150Z",
     "iopub.status.busy": "2023-09-06T14:22:36.980456Z",
     "iopub.status.idle": "2023-09-06T14:22:37.026261Z",
     "shell.execute_reply": "2023-09-06T14:22:37.024308Z"
    },
    "papermill": {
     "duration": 0.080687,
     "end_time": "2023-09-06T14:22:37.029705",
     "exception": false,
     "start_time": "2023-09-06T14:22:36.949018",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "WP_long <- regional_WP %>% \n",
    "  select(date,\n",
    "         Newfoundland_and_Labrador,\n",
    "         Prince_Edward_Island,\n",
    "         Nova_Scotia,\n",
    "         New_Brunswick,\n",
    "         Quebec,\n",
    "         Ontario,\n",
    "         Manitoba,\n",
    "         Saskatchewan,\n",
    "         Alberta,\n",
    "         British_Columbia,\n",
    "         Yukon,\n",
    "         Northwest_Territories,\n",
    "         Nunavut,\n",
    "         Province_or_Territory_not_stated\n",
    "         ) %>% \n",
    "  pivot_longer(cols = c(Newfoundland_and_Labrador,\n",
    "                        Prince_Edward_Island,\n",
    "                        Nova_Scotia,\n",
    "                        New_Brunswick,\n",
    "                        Quebec,\n",
    "                        Ontario,\n",
    "                        Manitoba,\n",
    "                        Saskatchewan,\n",
    "                        Alberta,\n",
    "                        British_Columbia,\n",
    "                        Yukon,\n",
    "                        Northwest_Territories,\n",
    "                        Nunavut,\n",
    "                        Province_or_Territory_not_stated),\n",
    "               names_to = \"regions\", values_to = \"WP_holder\")%>% \n",
    "  rename(year = date)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "0b2d5129",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.091700Z",
     "iopub.status.busy": "2023-09-06T14:22:37.089923Z",
     "iopub.status.idle": "2023-09-06T14:22:37.121985Z",
     "shell.execute_reply": "2023-09-06T14:22:37.119533Z"
    },
    "papermill": {
     "duration": 0.066739,
     "end_time": "2023-09-06T14:22:37.125272",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.058533",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>year</th><th scope=col>regions</th><th scope=col>WP_holder</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2000</td><td>Newfoundland_and_Labrador</td><td> 565</td></tr>\n",
       "\t<tr><td>2000</td><td>Prince_Edward_Island     </td><td>  45</td></tr>\n",
       "\t<tr><td>2000</td><td>Nova_Scotia              </td><td> 390</td></tr>\n",
       "\t<tr><td>2000</td><td>New_Brunswick            </td><td> 190</td></tr>\n",
       "\t<tr><td>2000</td><td>Quebec                   </td><td>2930</td></tr>\n",
       "\t<tr><td>2000</td><td>Ontario                  </td><td>9005</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " year & regions & WP\\_holder\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2000 & Newfoundland\\_and\\_Labrador &  565\\\\\n",
       "\t 2000 & Prince\\_Edward\\_Island      &   45\\\\\n",
       "\t 2000 & Nova\\_Scotia               &  390\\\\\n",
       "\t 2000 & New\\_Brunswick             &  190\\\\\n",
       "\t 2000 & Quebec                    & 2930\\\\\n",
       "\t 2000 & Ontario                   & 9005\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 3\n",
       "\n",
       "| year &lt;dbl&gt; | regions &lt;chr&gt; | WP_holder &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2000 | Newfoundland_and_Labrador |  565 |\n",
       "| 2000 | Prince_Edward_Island      |   45 |\n",
       "| 2000 | Nova_Scotia               |  390 |\n",
       "| 2000 | New_Brunswick             |  190 |\n",
       "| 2000 | Quebec                    | 2930 |\n",
       "| 2000 | Ontario                   | 9005 |\n",
       "\n"
      ],
      "text/plain": [
       "  year regions                   WP_holder\n",
       "1 2000 Newfoundland_and_Labrador  565     \n",
       "2 2000 Prince_Edward_Island        45     \n",
       "3 2000 Nova_Scotia                390     \n",
       "4 2000 New_Brunswick              190     \n",
       "5 2000 Quebec                    2930     \n",
       "6 2000 Ontario                   9005     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(WP_long)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "887df49d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.188806Z",
     "iopub.status.busy": "2023-09-06T14:22:37.186879Z",
     "iopub.status.idle": "2023-09-06T14:22:37.231029Z",
     "shell.execute_reply": "2023-09-06T14:22:37.228951Z"
    },
    "papermill": {
     "duration": 0.085465,
     "end_time": "2023-09-06T14:22:37.240605",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.155140",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "PR_long <- regional_PR %>% \n",
    "  select(year,\n",
    "         Newfoundland_and_Labrador,\n",
    "         Prince_Edward_Island,\n",
    "         Nova_Scotia,\n",
    "         New_Brunswick,\n",
    "         Quebec,\n",
    "         Ontario,\n",
    "         Manitoba,\n",
    "         Saskatchewan,\n",
    "         Alberta,\n",
    "         British_Columbia,\n",
    "         Yukon,\n",
    "         Northwest_Territories,\n",
    "         Nunavut,\n",
    "         Province_or_Territory_not_stated\n",
    "         ) %>% \n",
    "  pivot_longer(cols = c(Newfoundland_and_Labrador,\n",
    "                        Prince_Edward_Island,\n",
    "                        Nova_Scotia,\n",
    "                        New_Brunswick,\n",
    "                        Quebec,\n",
    "                        Ontario,\n",
    "                        Manitoba,\n",
    "                        Saskatchewan,\n",
    "                        Alberta,\n",
    "                        British_Columbia,\n",
    "                        Yukon,\n",
    "                        Northwest_Territories,\n",
    "                        Nunavut,\n",
    "                        Province_or_Territory_not_stated),\n",
    "               names_to = \"regions\", values_to = \"PR_holder\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "0e4a3ac7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.306870Z",
     "iopub.status.busy": "2023-09-06T14:22:37.304860Z",
     "iopub.status.idle": "2023-09-06T14:22:37.336202Z",
     "shell.execute_reply": "2023-09-06T14:22:37.334074Z"
    },
    "papermill": {
     "duration": 0.067012,
     "end_time": "2023-09-06T14:22:37.339046",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.272034",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>year</th><th scope=col>regions</th><th scope=col>PR_holder</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2015</td><td>Newfoundland_and_Labrador</td><td>50   </td></tr>\n",
       "\t<tr><td>2015</td><td>Prince_Edward_Island     </td><td>45   </td></tr>\n",
       "\t<tr><td>2015</td><td>Nova_Scotia              </td><td>130  </td></tr>\n",
       "\t<tr><td>2015</td><td>New_Brunswick            </td><td>125  </td></tr>\n",
       "\t<tr><td>2015</td><td>Quebec                   </td><td>2,090</td></tr>\n",
       "\t<tr><td>2015</td><td>Ontario                  </td><td>5,320</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " year & regions & PR\\_holder\\\\\n",
       " <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t 2015 & Newfoundland\\_and\\_Labrador & 50   \\\\\n",
       "\t 2015 & Prince\\_Edward\\_Island      & 45   \\\\\n",
       "\t 2015 & Nova\\_Scotia               & 130  \\\\\n",
       "\t 2015 & New\\_Brunswick             & 125  \\\\\n",
       "\t 2015 & Quebec                    & 2,090\\\\\n",
       "\t 2015 & Ontario                   & 5,320\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 3\n",
       "\n",
       "| year &lt;dbl&gt; | regions &lt;chr&gt; | PR_holder &lt;chr&gt; |\n",
       "|---|---|---|\n",
       "| 2015 | Newfoundland_and_Labrador | 50    |\n",
       "| 2015 | Prince_Edward_Island      | 45    |\n",
       "| 2015 | Nova_Scotia               | 130   |\n",
       "| 2015 | New_Brunswick             | 125   |\n",
       "| 2015 | Quebec                    | 2,090 |\n",
       "| 2015 | Ontario                   | 5,320 |\n",
       "\n"
      ],
      "text/plain": [
       "  year regions                   PR_holder\n",
       "1 2015 Newfoundland_and_Labrador 50       \n",
       "2 2015 Prince_Edward_Island      45       \n",
       "3 2015 Nova_Scotia               130      \n",
       "4 2015 New_Brunswick             125      \n",
       "5 2015 Quebec                    2,090    \n",
       "6 2015 Ontario                   5,320    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(PR_long)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "58369891",
   "metadata": {
    "papermill": {
     "duration": 0.030656,
     "end_time": "2023-09-06T14:22:37.400324",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.369668",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Lets combine them together\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "bb6ab8fd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.465571Z",
     "iopub.status.busy": "2023-09-06T14:22:37.463316Z",
     "iopub.status.idle": "2023-09-06T14:22:37.492678Z",
     "shell.execute_reply": "2023-09-06T14:22:37.490588Z"
    },
    "papermill": {
     "duration": 0.065453,
     "end_time": "2023-09-06T14:22:37.495605",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.430152",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data <- PR_long %>%\n",
    "  full_join(WP_long, by = c(\"year\", \"regions\")) %>%\n",
    "  full_join(study_permit_long, by = c(\"year\", \"regions\")) %>%\n",
    "  full_join(yearly_population, by = c(\"year\", \"regions\")) %>% \n",
    "  filter(year <= 2022, year >= 2015)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "ec1bb043",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.559670Z",
     "iopub.status.busy": "2023-09-06T14:22:37.557901Z",
     "iopub.status.idle": "2023-09-06T14:22:37.595811Z",
     "shell.execute_reply": "2023-09-06T14:22:37.593146Z"
    },
    "papermill": {
     "duration": 0.073652,
     "end_time": "2023-09-06T14:22:37.598943",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.525291",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>year</th><th scope=col>regions</th><th scope=col>PR_holder</th><th scope=col>WP_holder</th><th scope=col>study_permit_holder</th><th scope=col>population</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2015</td><td>Newfoundland_and_Labrador</td><td>50   </td><td>  590</td><td>  2965</td><td>  528696</td></tr>\n",
       "\t<tr><td>2015</td><td>Prince_Edward_Island     </td><td>45   </td><td>  400</td><td>  1610</td><td>  144894</td></tr>\n",
       "\t<tr><td>2015</td><td>Nova_Scotia              </td><td>130  </td><td>  710</td><td> 11515</td><td>  938320</td></tr>\n",
       "\t<tr><td>2015</td><td>New_Brunswick            </td><td>125  </td><td>  990</td><td>  4595</td><td>  759778</td></tr>\n",
       "\t<tr><td>2015</td><td>Quebec                   </td><td>2,090</td><td> 7370</td><td> 50815</td><td> 8190014</td></tr>\n",
       "\t<tr><td>2015</td><td>Ontario                  </td><td>5,320</td><td>14115</td><td>151610</td><td>13757688</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 6\n",
       "\\begin{tabular}{llllll}\n",
       " year & regions & PR\\_holder & WP\\_holder & study\\_permit\\_holder & population\\\\\n",
       " <dbl> & <chr> & <chr> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2015 & Newfoundland\\_and\\_Labrador & 50    &   590 &   2965 &   528696\\\\\n",
       "\t 2015 & Prince\\_Edward\\_Island      & 45    &   400 &   1610 &   144894\\\\\n",
       "\t 2015 & Nova\\_Scotia               & 130   &   710 &  11515 &   938320\\\\\n",
       "\t 2015 & New\\_Brunswick             & 125   &   990 &   4595 &   759778\\\\\n",
       "\t 2015 & Quebec                    & 2,090 &  7370 &  50815 &  8190014\\\\\n",
       "\t 2015 & Ontario                   & 5,320 & 14115 & 151610 & 13757688\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 6\n",
       "\n",
       "| year &lt;dbl&gt; | regions &lt;chr&gt; | PR_holder &lt;chr&gt; | WP_holder &lt;dbl&gt; | study_permit_holder &lt;dbl&gt; | population &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|\n",
       "| 2015 | Newfoundland_and_Labrador | 50    |   590 |   2965 |   528696 |\n",
       "| 2015 | Prince_Edward_Island      | 45    |   400 |   1610 |   144894 |\n",
       "| 2015 | Nova_Scotia               | 130   |   710 |  11515 |   938320 |\n",
       "| 2015 | New_Brunswick             | 125   |   990 |   4595 |   759778 |\n",
       "| 2015 | Quebec                    | 2,090 |  7370 |  50815 |  8190014 |\n",
       "| 2015 | Ontario                   | 5,320 | 14115 | 151610 | 13757688 |\n",
       "\n"
      ],
      "text/plain": [
       "  year regions                   PR_holder WP_holder study_permit_holder\n",
       "1 2015 Newfoundland_and_Labrador 50          590       2965             \n",
       "2 2015 Prince_Edward_Island      45          400       1610             \n",
       "3 2015 Nova_Scotia               130         710      11515             \n",
       "4 2015 New_Brunswick             125         990       4595             \n",
       "5 2015 Quebec                    2,090      7370      50815             \n",
       "6 2015 Ontario                   5,320     14115     151610             \n",
       "  population\n",
       "1   528696  \n",
       "2   144894  \n",
       "3   938320  \n",
       "4   759778  \n",
       "5  8190014  \n",
       "6 13757688  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(combined_data)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "253dac2d",
   "metadata": {
    "papermill": {
     "duration": 0.030502,
     "end_time": "2023-09-06T14:22:37.660431",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.629929",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "While combining, some data might be change type, to make sure, I change the data type to the correct one, and remove all N/A value for avoiding calculation error.\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "27b4aec2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.726478Z",
     "iopub.status.busy": "2023-09-06T14:22:37.724457Z",
     "iopub.status.idle": "2023-09-06T14:22:37.742195Z",
     "shell.execute_reply": "2023-09-06T14:22:37.740043Z"
    },
    "papermill": {
     "duration": 0.053164,
     "end_time": "2023-09-06T14:22:37.744858",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.691694",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data$PR_holder <- as.numeric(gsub(\",\", \"\", combined_data$PR_holder))\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "1d257195",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.808179Z",
     "iopub.status.busy": "2023-09-06T14:22:37.806296Z",
     "iopub.status.idle": "2023-09-06T14:22:37.824112Z",
     "shell.execute_reply": "2023-09-06T14:22:37.822047Z"
    },
    "papermill": {
     "duration": 0.052318,
     "end_time": "2023-09-06T14:22:37.826759",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.774441",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data$WP_holder <- as.numeric(gsub(\",\", \"\", combined_data$WP_holder))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "0ee2820b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.890909Z",
     "iopub.status.busy": "2023-09-06T14:22:37.888972Z",
     "iopub.status.idle": "2023-09-06T14:22:37.906794Z",
     "shell.execute_reply": "2023-09-06T14:22:37.904773Z"
    },
    "papermill": {
     "duration": 0.052837,
     "end_time": "2023-09-06T14:22:37.909479",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.856642",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data$study_permit_holder <- as.numeric(gsub(\",\", \"\", combined_data$study_permit_holder))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "b0fb079d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:37.973932Z",
     "iopub.status.busy": "2023-09-06T14:22:37.971927Z",
     "iopub.status.idle": "2023-09-06T14:22:37.995877Z",
     "shell.execute_reply": "2023-09-06T14:22:37.993744Z"
    },
    "papermill": {
     "duration": 0.059483,
     "end_time": "2023-09-06T14:22:37.999077",
     "exception": false,
     "start_time": "2023-09-06T14:22:37.939594",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data$population <- as.numeric(combined_data$population)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 29,
   "id": "69d432ed",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:38.064259Z",
     "iopub.status.busy": "2023-09-06T14:22:38.062564Z",
     "iopub.status.idle": "2023-09-06T14:22:38.079180Z",
     "shell.execute_reply": "2023-09-06T14:22:38.077074Z"
    },
    "papermill": {
     "duration": 0.052739,
     "end_time": "2023-09-06T14:22:38.082593",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.029854",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data <- na.omit(combined_data)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e0a4f086",
   "metadata": {
    "papermill": {
     "duration": 0.030227,
     "end_time": "2023-09-06T14:22:38.142798",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.112571",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Then I added PR holder, WP holder, and study permit holder into new column called, total_immigrant\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "ddfcd849",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:38.207720Z",
     "iopub.status.busy": "2023-09-06T14:22:38.205719Z",
     "iopub.status.idle": "2023-09-06T14:22:38.224866Z",
     "shell.execute_reply": "2023-09-06T14:22:38.222712Z"
    },
    "papermill": {
     "duration": 0.055513,
     "end_time": "2023-09-06T14:22:38.228464",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.172951",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data <- combined_data%>% \n",
    "  mutate(total_immigrant = PR_holder + WP_holder + study_permit_holder)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e956cbc5",
   "metadata": {
    "papermill": {
     "duration": 0.030463,
     "end_time": "2023-09-06T14:22:38.288763",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.258300",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Then, converting to the long data frame"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "id": "649a228c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:38.353296Z",
     "iopub.status.busy": "2023-09-06T14:22:38.351176Z",
     "iopub.status.idle": "2023-09-06T14:22:38.381901Z",
     "shell.execute_reply": "2023-09-06T14:22:38.379679Z"
    },
    "papermill": {
     "duration": 0.066045,
     "end_time": "2023-09-06T14:22:38.384820",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.318775",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "combined_data_long <- combined_data %>% \n",
    "  select(total_immigrant,\n",
    "         population,\n",
    "         regions,\n",
    "         year) %>% \n",
    "  pivot_longer(cols = c(total_immigrant,\n",
    "                        population),\n",
    "               names_to = \"Type\", values_to = \"number\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 32,
   "id": "00730af7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:38.449162Z",
     "iopub.status.busy": "2023-09-06T14:22:38.447370Z",
     "iopub.status.idle": "2023-09-06T14:22:38.478931Z",
     "shell.execute_reply": "2023-09-06T14:22:38.476999Z"
    },
    "papermill": {
     "duration": 0.066398,
     "end_time": "2023-09-06T14:22:38.481485",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.415087",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>regions</th><th scope=col>year</th><th scope=col>Type</th><th scope=col>number</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Newfoundland_and_Labrador</td><td>2015</td><td>total_immigrant</td><td>  3605</td></tr>\n",
       "\t<tr><td>Newfoundland_and_Labrador</td><td>2015</td><td>population     </td><td>528696</td></tr>\n",
       "\t<tr><td>Prince_Edward_Island     </td><td>2015</td><td>total_immigrant</td><td>  2055</td></tr>\n",
       "\t<tr><td>Prince_Edward_Island     </td><td>2015</td><td>population     </td><td>144894</td></tr>\n",
       "\t<tr><td>Nova_Scotia              </td><td>2015</td><td>total_immigrant</td><td> 12355</td></tr>\n",
       "\t<tr><td>Nova_Scotia              </td><td>2015</td><td>population     </td><td>938320</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 4\n",
       "\\begin{tabular}{llll}\n",
       " regions & year & Type & number\\\\\n",
       " <chr> & <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Newfoundland\\_and\\_Labrador & 2015 & total\\_immigrant &   3605\\\\\n",
       "\t Newfoundland\\_and\\_Labrador & 2015 & population      & 528696\\\\\n",
       "\t Prince\\_Edward\\_Island      & 2015 & total\\_immigrant &   2055\\\\\n",
       "\t Prince\\_Edward\\_Island      & 2015 & population      & 144894\\\\\n",
       "\t Nova\\_Scotia               & 2015 & total\\_immigrant &  12355\\\\\n",
       "\t Nova\\_Scotia               & 2015 & population      & 938320\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 4\n",
       "\n",
       "| regions &lt;chr&gt; | year &lt;dbl&gt; | Type &lt;chr&gt; | number &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| Newfoundland_and_Labrador | 2015 | total_immigrant |   3605 |\n",
       "| Newfoundland_and_Labrador | 2015 | population      | 528696 |\n",
       "| Prince_Edward_Island      | 2015 | total_immigrant |   2055 |\n",
       "| Prince_Edward_Island      | 2015 | population      | 144894 |\n",
       "| Nova_Scotia               | 2015 | total_immigrant |  12355 |\n",
       "| Nova_Scotia               | 2015 | population      | 938320 |\n",
       "\n"
      ],
      "text/plain": [
       "  regions                   year Type            number\n",
       "1 Newfoundland_and_Labrador 2015 total_immigrant   3605\n",
       "2 Newfoundland_and_Labrador 2015 population      528696\n",
       "3 Prince_Edward_Island      2015 total_immigrant   2055\n",
       "4 Prince_Edward_Island      2015 population      144894\n",
       "5 Nova_Scotia               2015 total_immigrant  12355\n",
       "6 Nova_Scotia               2015 population      938320"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(combined_data_long)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "464d500f",
   "metadata": {
    "papermill": {
     "duration": 0.030318,
     "end_time": "2023-09-06T14:22:38.542375",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.512057",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Notice the difference between total population and total immigrant is large, to have better visual, the number of population must be scale down\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "id": "4ef8194f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:38.606871Z",
     "iopub.status.busy": "2023-09-06T14:22:38.604939Z",
     "iopub.status.idle": "2023-09-06T14:22:38.623635Z",
     "shell.execute_reply": "2023-09-06T14:22:38.621375Z"
    },
    "papermill": {
     "duration": 0.054055,
     "end_time": "2023-09-06T14:22:38.626489",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.572434",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "scaled_data <- combined_data_long\n",
    "scaled_data$number <- ifelse(scaled_data$Type == \"population\", scaled_data$number / 10, scaled_data$number)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "85473f8b",
   "metadata": {
    "papermill": {
     "duration": 0.032357,
     "end_time": "2023-09-06T14:22:38.689044",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.656687",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Now it ready for plotting"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 34,
   "id": "f79ed568",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:38.753475Z",
     "iopub.status.busy": "2023-09-06T14:22:38.751611Z",
     "iopub.status.idle": "2023-09-06T14:22:39.935264Z",
     "shell.execute_reply": "2023-09-06T14:22:39.933209Z"
    },
    "papermill": {
     "duration": 1.219016,
     "end_time": "2023-09-06T14:22:39.938251",
     "exception": false,
     "start_time": "2023-09-06T14:22:38.719235",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\n1PXCK64M64ahh64fbSWC7gHDjz56xGAXx4joyKtfjy9HV3fLHGNMPHniuRdf9WGSxhnzfz+U\niBjjexxwyHGHHWiNH1vY7/QfwvXj3KY93InTLtqbgk0Hnn1yykFExIn+ISOPG9q3MxGNu3sR\nEfl73mDNYA13cuwL6xIXa6f/m+3eJhVouW+bbaxpmgd6RF7qmqK3bQYuveXb3FDt1MHmoqLB\nz6yhCl0dDjz1zLNLRw5xc0zyHTTUKyYb7iRHwgQAkAk4Y5dNFz7+yT+funFEV+6H1T/o/s6j\nzr78L6t/vu7o+tEWjpy34i+PzD58YMnXnyxfvnKVt/+Yt/67cdl99z4+5Xgft+uN19/VTGKc\n549//99bj9x4/NCu2//3xVc//tbviJPve/HTzx+tf/8SJ5R8cM8lvTp6/vHnt/75XXmS6rCZ\nL63+aMndpx41KLz1h8+/21zcf+Tltz31/dq3Brpz/l7Mac9//d6jN540su/mb74qF/rOfe7z\nN6b3JiJe6p6ilJ3+J1vd26Z92+aBa3FDtV+HFhclFRz131VvXzTuqILYhuVvv/HxF2v47scs\n+c/KA9xJT5jlSJgAADKBmRh7KRuu7u5/fGvNqprYwV5c32lz5du3RnSzc7fuiSNZVP48K9B/\nfp/TP1r/zonZq1p714obahqL0kJ7NmwJ9x3Qs5kHmAEAoDk4Ywf574XjhvTo0ePu9Q3GNvvX\n3X8hopEzUz2MCdkleEv6I6sDAHACiR3kv4kPnEZE80dPff/r9WFVD1VsfvvRq89c+pNcdNzj\nR3XJdu0AAABaDW4cgfzX+/QXn79m18WPvj3u0LfiE73dRy7+2zsdbL/BAgAAoP1DYpcdkx58\nYnhY7SXjKlNmsAsX/O3USz958/2V67dVSgXFg0Yce8Zpx/vx/oCWtOKGim0eACAD8PAEAAAA\nQJ7AdSgAAACAPIHEDgAAACBPILEDAAAAyBNI7AAAAADyBBI7AAAAgDyBxA4AAAAgTyCxAwAA\nAMgTSOwAAAAA8gTePGHXrl27otFotmsB9Xr06NHsdESqvUkWqZ07d8ZisQxXBlJApHJFskgB\nEBI7+6LRaDgcznYtoGWKokQikWzXAloWjUYRqZygKIqiKNmuBQDYgkuxAAAAAHkCiR0AAABA\nnkBiBwAAAJAnkNgBAAAA5AkkdgAAAAB5AokdAAAAQJ5AYgcAAACQJ5DYAQAAAOQJJHa5x9CD\n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\nmtZaKJKbQvdZV0urfNOluvc1p+ZDe7Zr4dtsUHC/b+r4WgjMcgwAwHco1Ic8mAdHrxnYfOTW\n7MsqRTN+7ZTxq0+9P1v+vPLM+pG4g2trmszIpf/FN569rPbnpxWca3ad3Xr/tG2Ldb3WkQA9\n2rXtviEsctac/96kSmSlW3QdPsG/xa9+3x/6IId3ozpeaHni8BxlcuSa8N8u3X6aqqRLlKvS\nKWD8j6089Evr3LbNwF27369ZcOa++I8/5ndo07rrzmMjSou1ijebwleeunI/RUNVqNag/6jx\nPpUK78kL/RG7tm3b7tq1a82aNffv3//jjz/atGmzc+dO/anYdu3abdiwYdasWW/evJHJZF27\ndvX39wcAuVy+dOnSO3fuKBSKRo0aTZgwQSgU6he4atWqGzdufPjwoWrVqkOGDKlZM1/HABIS\nEpYuXRoZGcnj8Xr06KEf2bt3b09Pz0WLFgHA9u3bt2zZsnnzZk9PTwDo0aNH7dq1Z82alZyc\nHB4efvv2baVSWa5cuYCAgFatWuVurMnlM3ft2rXNmzdHRUWJxeJmzZoFBwfn6KKZC8PCd1uo\naDLvL7ue0Hj28hy/JlnNrnPa7J+6fZG2zwaKVvu0/m7w3r9+LJl9oLdHu7aNtx6e6C7RaT7s\nXrXy3I3INx+UZavW6zUkuEPNTzsSKZF/L1m148HrJEnpSp39xw74rgoAmCuilb/auHTdv3ci\nExW8Go3aBU0Y6iksvL1hK2TqaFXSe+MxFbqOm1f+gw6ABDC3LXp/7ejyzX9ERr0jxSW8m/lO\nDe4r/rwnpEp9MHHA+Iwmw9dP7EYRppeTY7tn7qvWahJ/mznl6PXHhKhkiy7DJwa01FdhMmXr\ne/ue95y5Z1EjAHi+fdiQLU+7bD4y1tMRAJb06Hin9oJds+qZa5TJjbNdksCClsF9DwXot5Pv\nfPtm70QdWP/ModxsACjZvKU6a/6u2Mz+pcUAQGszwp+mlB3qDXDXXBG9pI8vTciK35+s+ewF\nCsmPQ05EKWIVx0pxSQDIis9jv8J8DEUD05snXuz6YeTWiDYjl9999k4/xrnyLwuGNr2wYVSX\ndY9tFh7Klv52n5amBzQycXy0hv83mqwnV9Ozd1wOjZ3j2WvClp3bJvTxPr555va4zMBdf4ws\nIyn3ffihPdMBYEPQ5IuJ5SfMD1+3MsyvgW5L6IhY1acdkYthkyVN+ixfFWJUg27FsMAj93RD\n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\nAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(scaled_data) +\n",
    "  geom_line(aes(x = year, y = number, color = Type), linewidth = 1) +\n",
    "  facet_wrap(~ regions) +\n",
    "  labs(title = \"Impact of immigration on population\", x = \"Year\", y = \"Number of people / Population (x10)\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b91116af",
   "metadata": {
    "papermill": {
     "duration": 0.033173,
     "end_time": "2023-09-06T14:22:40.004531",
     "exception": false,
     "start_time": "2023-09-06T14:22:39.971358",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "We can see that the majority of population and immigration is centralized in Alberta, BC, QC, and Ontario. Except from Ontario, all other provinces have similar increasing rate and trend between population and immigration. Except for Ontario, there was a slight decrease in number of immigration in 2020. \n",
    "\n",
    "In contrary, we see the population growth rate has a hike a round this time, so the immigration is not the major factor for this increase, noting that the COVID pandemic was happening around this time as well, which forcing people to stay home, which may lead to the increasing in birth rate. However, this is not within the scope of this analysis.\n",
    "\n",
    "## Housing price\n",
    "### Comparing different types of property\n",
    "First of all, regarding housing_price data frame, column REF_DATE is not in correct format yet, so we need to fix it. By the code chunk below, I can change the format of the column and add 2 more column year, and month to separate them."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 35,
   "id": "8537f026",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:40.074927Z",
     "iopub.status.busy": "2023-09-06T14:22:40.072953Z",
     "iopub.status.idle": "2023-09-06T14:22:40.114965Z",
     "shell.execute_reply": "2023-09-06T14:22:40.112842Z"
    },
    "papermill": {
     "duration": 0.080238,
     "end_time": "2023-09-06T14:22:40.117709",
     "exception": false,
     "start_time": "2023-09-06T14:22:40.037471",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "housing_price <- housing_price %>%\n",
    "  mutate(\n",
    "    year = lubridate::year(REF_DATE),\n",
    "    month = lubridate::month(REF_DATE)\n",
    "  )"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 36,
   "id": "44ee2d33",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:40.187209Z",
     "iopub.status.busy": "2023-09-06T14:22:40.185153Z",
     "iopub.status.idle": "2023-09-06T14:22:40.241477Z",
     "shell.execute_reply": "2023-09-06T14:22:40.239355Z"
    },
    "papermill": {
     "duration": 0.09453,
     "end_time": "2023-09-06T14:22:40.244355",
     "exception": false,
     "start_time": "2023-09-06T14:22:40.149825",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 17</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>REF_DATE</th><th scope=col>GEO</th><th scope=col>DGUID</th><th scope=col>New housing price indexes</th><th scope=col>UOM</th><th scope=col>UOM_ID</th><th scope=col>SCALAR_FACTOR</th><th scope=col>SCALAR_ID</th><th scope=col>VECTOR</th><th scope=col>COORDINATE</th><th scope=col>VALUE</th><th scope=col>STATUS</th><th scope=col>SYMBOL</th><th scope=col>TERMINATED</th><th scope=col>DECIMALS</th><th scope=col>year</th><th scope=col>month</th></tr>\n",
       "\t<tr><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;lgl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1981-01-01</td><td>Canada         </td><td>2016A000011124</td><td>Total (house and land)</td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955442</td><td>1.1</td><td>38.2</td><td>NA</td><td>NA</td><td>NA</td><td>1</td><td>1981</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Canada         </td><td>2016A000011124</td><td>House only            </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955443</td><td>1.2</td><td>36.1</td><td>NA</td><td>NA</td><td>NA</td><td>1</td><td>1981</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Canada         </td><td>2016A000011124</td><td>Land only             </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955444</td><td>1.3</td><td>40.6</td><td>E </td><td>NA</td><td>NA</td><td>1</td><td>1981</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Atlantic Region</td><td>2016A00011    </td><td>Total (house and land)</td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955445</td><td>2.1</td><td>  NA</td><td>..</td><td>NA</td><td>NA</td><td>1</td><td>1981</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Atlantic Region</td><td>2016A00011    </td><td>House only            </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955446</td><td>2.2</td><td>  NA</td><td>..</td><td>NA</td><td>NA</td><td>1</td><td>1981</td><td>1</td></tr>\n",
       "\t<tr><td>1981-01-01</td><td>Atlantic Region</td><td>2016A00011    </td><td>Land only             </td><td>Index, 201612=100</td><td>347</td><td>units</td><td>0</td><td>v111955447</td><td>2.3</td><td>  NA</td><td>..</td><td>NA</td><td>NA</td><td>1</td><td>1981</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 17\n",
       "\\begin{tabular}{lllllllllllllllll}\n",
       " REF\\_DATE & GEO & DGUID & New housing price indexes & UOM & UOM\\_ID & SCALAR\\_FACTOR & SCALAR\\_ID & VECTOR & COORDINATE & VALUE & STATUS & SYMBOL & TERMINATED & DECIMALS & year & month\\\\\n",
       " <date> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <chr> & <lgl> & <lgl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1981-01-01 & Canada          & 2016A000011124 & Total (house and land) & Index, 201612=100 & 347 & units & 0 & v111955442 & 1.1 & 38.2 & NA & NA & NA & 1 & 1981 & 1\\\\\n",
       "\t 1981-01-01 & Canada          & 2016A000011124 & House only             & Index, 201612=100 & 347 & units & 0 & v111955443 & 1.2 & 36.1 & NA & NA & NA & 1 & 1981 & 1\\\\\n",
       "\t 1981-01-01 & Canada          & 2016A000011124 & Land only              & Index, 201612=100 & 347 & units & 0 & v111955444 & 1.3 & 40.6 & E  & NA & NA & 1 & 1981 & 1\\\\\n",
       "\t 1981-01-01 & Atlantic Region & 2016A00011     & Total (house and land) & Index, 201612=100 & 347 & units & 0 & v111955445 & 2.1 &   NA & .. & NA & NA & 1 & 1981 & 1\\\\\n",
       "\t 1981-01-01 & Atlantic Region & 2016A00011     & House only             & Index, 201612=100 & 347 & units & 0 & v111955446 & 2.2 &   NA & .. & NA & NA & 1 & 1981 & 1\\\\\n",
       "\t 1981-01-01 & Atlantic Region & 2016A00011     & Land only              & Index, 201612=100 & 347 & units & 0 & v111955447 & 2.3 &   NA & .. & NA & NA & 1 & 1981 & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 17\n",
       "\n",
       "| REF_DATE &lt;date&gt; | GEO &lt;chr&gt; | DGUID &lt;chr&gt; | New housing price indexes &lt;chr&gt; | UOM &lt;chr&gt; | UOM_ID &lt;dbl&gt; | SCALAR_FACTOR &lt;chr&gt; | SCALAR_ID &lt;dbl&gt; | VECTOR &lt;chr&gt; | COORDINATE &lt;dbl&gt; | VALUE &lt;dbl&gt; | STATUS &lt;chr&gt; | SYMBOL &lt;lgl&gt; | TERMINATED &lt;lgl&gt; | DECIMALS &lt;dbl&gt; | year &lt;dbl&gt; | month &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1981-01-01 | Canada          | 2016A000011124 | Total (house and land) | Index, 201612=100 | 347 | units | 0 | v111955442 | 1.1 | 38.2 | NA | NA | NA | 1 | 1981 | 1 |\n",
       "| 1981-01-01 | Canada          | 2016A000011124 | House only             | Index, 201612=100 | 347 | units | 0 | v111955443 | 1.2 | 36.1 | NA | NA | NA | 1 | 1981 | 1 |\n",
       "| 1981-01-01 | Canada          | 2016A000011124 | Land only              | Index, 201612=100 | 347 | units | 0 | v111955444 | 1.3 | 40.6 | E  | NA | NA | 1 | 1981 | 1 |\n",
       "| 1981-01-01 | Atlantic Region | 2016A00011     | Total (house and land) | Index, 201612=100 | 347 | units | 0 | v111955445 | 2.1 |   NA | .. | NA | NA | 1 | 1981 | 1 |\n",
       "| 1981-01-01 | Atlantic Region | 2016A00011     | House only             | Index, 201612=100 | 347 | units | 0 | v111955446 | 2.2 |   NA | .. | NA | NA | 1 | 1981 | 1 |\n",
       "| 1981-01-01 | Atlantic Region | 2016A00011     | Land only              | Index, 201612=100 | 347 | units | 0 | v111955447 | 2.3 |   NA | .. | NA | NA | 1 | 1981 | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  REF_DATE   GEO             DGUID          New housing price indexes\n",
       "1 1981-01-01 Canada          2016A000011124 Total (house and land)   \n",
       "2 1981-01-01 Canada          2016A000011124 House only               \n",
       "3 1981-01-01 Canada          2016A000011124 Land only                \n",
       "4 1981-01-01 Atlantic Region 2016A00011     Total (house and land)   \n",
       "5 1981-01-01 Atlantic Region 2016A00011     House only               \n",
       "6 1981-01-01 Atlantic Region 2016A00011     Land only                \n",
       "  UOM               UOM_ID SCALAR_FACTOR SCALAR_ID VECTOR     COORDINATE VALUE\n",
       "1 Index, 201612=100 347    units         0         v111955442 1.1        38.2 \n",
       "2 Index, 201612=100 347    units         0         v111955443 1.2        36.1 \n",
       "3 Index, 201612=100 347    units         0         v111955444 1.3        40.6 \n",
       "4 Index, 201612=100 347    units         0         v111955445 2.1          NA \n",
       "5 Index, 201612=100 347    units         0         v111955446 2.2          NA \n",
       "6 Index, 201612=100 347    units         0         v111955447 2.3          NA \n",
       "  STATUS SYMBOL TERMINATED DECIMALS year month\n",
       "1 NA     NA     NA         1        1981 1    \n",
       "2 NA     NA     NA         1        1981 1    \n",
       "3 E      NA     NA         1        1981 1    \n",
       "4 ..     NA     NA         1        1981 1    \n",
       "5 ..     NA     NA         1        1981 1    \n",
       "6 ..     NA     NA         1        1981 1    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(housing_price)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "980e0e26",
   "metadata": {
    "papermill": {
     "duration": 0.033053,
     "end_time": "2023-09-06T14:22:40.309933",
     "exception": false,
     "start_time": "2023-09-06T14:22:40.276880",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Then I want to clear all N/A cells which may cause error in plot later.\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 37,
   "id": "fe80c12e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:40.380219Z",
     "iopub.status.busy": "2023-09-06T14:22:40.378313Z",
     "iopub.status.idle": "2023-09-06T14:22:40.414080Z",
     "shell.execute_reply": "2023-09-06T14:22:40.411954Z"
    },
    "papermill": {
     "duration": 0.074028,
     "end_time": "2023-09-06T14:22:40.417024",
     "exception": false,
     "start_time": "2023-09-06T14:22:40.342996",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "price_index <- housing_price %>%  \n",
    "  select(year,\n",
    "         month,\n",
    "         GEO,\n",
    "         \"New housing price indexes\",\n",
    "         VALUE) %>% \n",
    "  na.omit() %>% \n",
    "  rename(regions = GEO, property_type = \"New housing price indexes\", price_index = VALUE)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 38,
   "id": "bdab1700",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:40.488278Z",
     "iopub.status.busy": "2023-09-06T14:22:40.486320Z",
     "iopub.status.idle": "2023-09-06T14:22:40.560829Z",
     "shell.execute_reply": "2023-09-06T14:22:40.558876Z"
    },
    "papermill": {
     "duration": 0.113728,
     "end_time": "2023-09-06T14:22:40.563375",
     "exception": false,
     "start_time": "2023-09-06T14:22:40.449647",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 5</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>year</th><th scope=col>month</th><th scope=col>regions</th><th scope=col>property_type</th><th scope=col>price_index</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1981</td><td>1</td><td>Canada                               </td><td>Total (house and land)</td><td>38.2</td></tr>\n",
       "\t<tr><td>1981</td><td>1</td><td>Canada                               </td><td>House only            </td><td>36.1</td></tr>\n",
       "\t<tr><td>1981</td><td>1</td><td>Canada                               </td><td>Land only             </td><td>40.6</td></tr>\n",
       "\t<tr><td>1981</td><td>1</td><td>St. John's, Newfoundland and Labrador</td><td>Total (house and land)</td><td>36.1</td></tr>\n",
       "\t<tr><td>1981</td><td>1</td><td>St. John's, Newfoundland and Labrador</td><td>House only            </td><td>37.5</td></tr>\n",
       "\t<tr><td>1981</td><td>1</td><td>St. John's, Newfoundland and Labrador</td><td>Land only             </td><td>31.4</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 5\n",
       "\\begin{tabular}{lllll}\n",
       " year & month & regions & property\\_type & price\\_index\\\\\n",
       " <dbl> & <dbl> & <chr> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1981 & 1 & Canada                                & Total (house and land) & 38.2\\\\\n",
       "\t 1981 & 1 & Canada                                & House only             & 36.1\\\\\n",
       "\t 1981 & 1 & Canada                                & Land only              & 40.6\\\\\n",
       "\t 1981 & 1 & St. John's, Newfoundland and Labrador & Total (house and land) & 36.1\\\\\n",
       "\t 1981 & 1 & St. John's, Newfoundland and Labrador & House only             & 37.5\\\\\n",
       "\t 1981 & 1 & St. John's, Newfoundland and Labrador & Land only              & 31.4\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 5\n",
       "\n",
       "| year &lt;dbl&gt; | month &lt;dbl&gt; | regions &lt;chr&gt; | property_type &lt;chr&gt; | price_index &lt;dbl&gt; |\n",
       "|---|---|---|---|---|\n",
       "| 1981 | 1 | Canada                                | Total (house and land) | 38.2 |\n",
       "| 1981 | 1 | Canada                                | House only             | 36.1 |\n",
       "| 1981 | 1 | Canada                                | Land only              | 40.6 |\n",
       "| 1981 | 1 | St. John's, Newfoundland and Labrador | Total (house and land) | 36.1 |\n",
       "| 1981 | 1 | St. John's, Newfoundland and Labrador | House only             | 37.5 |\n",
       "| 1981 | 1 | St. John's, Newfoundland and Labrador | Land only              | 31.4 |\n",
       "\n"
      ],
      "text/plain": [
       "  year month regions                               property_type         \n",
       "1 1981 1     Canada                                Total (house and land)\n",
       "2 1981 1     Canada                                House only            \n",
       "3 1981 1     Canada                                Land only             \n",
       "4 1981 1     St. John's, Newfoundland and Labrador Total (house and land)\n",
       "5 1981 1     St. John's, Newfoundland and Labrador House only            \n",
       "6 1981 1     St. John's, Newfoundland and Labrador Land only             \n",
       "  price_index\n",
       "1 38.2       \n",
       "2 36.1       \n",
       "3 40.6       \n",
       "4 36.1       \n",
       "5 37.5       \n",
       "6 31.4       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(price_index)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cb59b9de",
   "metadata": {
    "papermill": {
     "duration": 0.03327,
     "end_time": "2023-09-06T14:22:40.629192",
     "exception": false,
     "start_time": "2023-09-06T14:22:40.595922",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Now, I would like to see the housing index distribution overtime for different property types:\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 39,
   "id": "a189ffe7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:40.699233Z",
     "iopub.status.busy": "2023-09-06T14:22:40.697477Z",
     "iopub.status.idle": "2023-09-06T14:22:41.370866Z",
     "shell.execute_reply": "2023-09-06T14:22:41.368819Z"
    },
    "papermill": {
     "duration": 0.711592,
     "end_time": "2023-09-06T14:22:41.373462",
     "exception": false,
     "start_time": "2023-09-06T14:22:40.661870",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“\u001b[1m\u001b[22mThe dot-dot notation (`..count..`) was deprecated in ggplot2 3.4.0.\n",
      "\u001b[36mℹ\u001b[39m Please use `after_stat(count)` instead.”\n"
     ]
    },
    {
     "data": {
      "image/png": "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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(data = price_index) +\n",
    "  geom_histogram(aes(x = price_index, fill = ..count..), binwidth = 10) +\n",
    "  facet_wrap(~ property_type) +\n",
    "  scale_fill_gradient(low = \"pink\", high = \"darkred\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "87e1b03e",
   "metadata": {
    "papermill": {
     "duration": 0.033877,
     "end_time": "2023-09-06T14:22:41.444513",
     "exception": false,
     "start_time": "2023-09-06T14:22:41.410636",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "We can see that, with 2016 is the based price, the house price is mostly either lower or same with 2016, and this pattern is the same for both house and land.\n",
    "\n",
    "### Average regional pricing index\n",
    "\n",
    "From \"price_index\" data frame, we can calculate average for each region overtime.\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 40,
   "id": "2fd1cfd1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-09-06T14:22:41.516016Z",
     "iopub.status.busy": "2023-09-06T14:22:41.514021Z",
     "iopub.status.idle": "2023-09-06T14:22:41.549726Z",
     "shell.execute_reply": "2023-09-06T14:22:41.547004Z"
    },
    "papermill": {
     "duration": 0.074703,
     "end_time": "2023-09-06T14:22:41.552886",
     "exception": false,
     "start_time": "2023-09-06T14:22:41.478183",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "average_price_index <- price_index %>% \n",
    "  group_by(regions) %>% \n",
    "  summarize(average_price_index = mean(price_index, na.rm = TRUE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "510b2644",
   "metadata": {
    "papermill": {
     "duration": 0.033945,
     "end_time": "2023-09-06T14:22:41.620181",
     "exception": false,
     "start_time": "2023-09-06T14:22:41.586236",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "In here, I used tableau for visualization, and, to do that, I need to have dataset, by using code chunk:\n",
    "\n",
    "write.csv(average_price_index, file = \"average_price_index_tableau.csv\")\n",
    "\n",
    "I already upload this data frame in here so no need to re-run this.\n",
    "\n",
    "And here the result we have."
   ]
  },
  {
   "attachments": {
    "5920af51-d613-4820-932c-6fb6b182a923.png": {
     "image/png": "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l2mU6+Tk5Obmdvny5T59+lS1z759+7799luzjwWynIODQ2ZmZvV5GuRAlZEkaW9vn5OT4+7ubpyu0WiKiopMHrtiCQ8PDw8Pj6FDh8bExCxYsODvv/+uVahszNfXNzY2tm77Nghvb+/ExESzK5CRJGlrazts2LCqHnvTIJjZBDqdjs0285grhqura3FxcY3rTt+5c+fs2bN79+5ds2YNc4NuPetW43EjIiI8PT0XLFhQzwNV1qdPny1btmg0mtTUVGtrazc3N7PZjh49OmXKFMNNwpaLjo42vk0dIYQQQgih15eZYGzy5Mnff/995QErA7lcXnm6r1qtrtWBO3TocPbs2epH7RrkQGZ179792LFjJoknT55s3769YQSMzWZrtdpaFRsYGMjj8epzE2b//v3//fffxMRE48RaPaqnnvr167d///6q3pcuXbpUfqoNANRzRq4xLpfbsmXLs2fPVpOnU6dO4eHhCoWimjzFxcWff/75F198wefzV6xYcfHixatXr9azbjUeVy6XV74EoFKpTFJsbW1LSkpqdWgej8ccPSwsbOjQoVVlk8lklStQ40dGo9EcPnzYeP1zhBBCCCGEXl9motw+ffp06NBh1qxZxivWpKWlHTx4kPk9ODjYeDXa7OzsVatWXblypVYHDgkJsbGx+eabbwzLJpWXl69bt844vmqQA5k1ceLE06dPX7hwwZBy+/btXbt2zZw505Di5+dnHBcVFxdv3rzZOMY7e/bs8ePHDfUHgMjISA6HY7IudK04ODgsXbp0+vTp+/btu3//fnh4+MqVK00eovNcde7c2cvLa926dYZHvMpksosXLzK/T548+dChQ8bNolAo9u/fv2vXrgasw5QpU7Zs2RIdHW1IuX79+h9//GF46erq2qdPn9DQUONrMTExMbNmzWJCUIqiVqxYMWHCBOZ2XKFQ+NVXX33xxRd5eXn1qViNx23ZsuWVK1cMESxFUWYXQ27Tps2JEyeMe44lmEnL4eHhZtdXYwQHB//555+GD5FCodi1a5fJ83Lh2YWji4uLlyxZ0r59+xqXB0cIIYQQQui1YH5S6Mcff3z48OE5c+ZYWVnZ2Njk5OSQJDl+/Hhm64IFCxYsWBAREeHl5ZWZmalSqWbMmGH541IZBEF8++23K1euHDlyZNu2baVSaUZGxtSpU0+fPm3I0yAHMsvFxWXj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"
    }
   },
   "cell_type": "markdown",
   "id": "37c6d3d7",
   "metadata": {
    "papermill": {
     "duration": 0.033848,
     "end_time": "2023-09-06T14:22:41.688026",
     "exception": false,
     "start_time": "2023-09-06T14:22:41.654178",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "![average_price_index.png](attachment:5920af51-d613-4820-932c-6fb6b182a923.png)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "034b9a5c",
   "metadata": {
    "papermill": {
     "duration": 0.03329,
     "end_time": "2023-09-06T14:22:41.754765",
     "exception": false,
     "start_time": "2023-09-06T14:22:41.721475",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "We can see that, unlike what most people think, the price index would be highest in some big cities like Toronto, or Vancouver, the highest one actually is Guelph.\n",
    "\n",
    "# Summary\n",
    "\n",
    "* Majority of population and immigration is centralized in Alberta, BC, QC, and Ontario. Except from Ontario, all other provinces have similar increasing rate and trend between population and immigration, and there was a slight decrease in number of immigration in 2020. In contrary, we see the population growth rate has a hike a round this time, so the immigration is not the major factor for this increase, noting that the COVID pandemic was happening around this time as well, which forcing people to stay home, which may lead to the increasing in birth rate. However, this is not within the scope of this analysis.\n",
    "\n",
    "* With 2016 is the based price, the house price is mostly either lower or same with 2016, and this pattern is the same for both house and land.\n",
    "\n",
    "* Unlike what most people think, the price index would be highest in some big cities like Toronto, or Vancouver, the highest one actually is Guelph."
   ]
  }
 ],
 "kernelspec": {
  "display_name": "R",
  "language": "R",
  "name": "ir"
 },
 "language_info": {
  "codemirror_mode": "r",
  "file_extension": ".r",
  "mimetype": "text/x-r-source",
  "name": "R",
  "pygments_lexer": "r",
  "version": "4.0.5"
 },
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 18.21347,
   "end_time": "2023-09-06T14:22:41.911859",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-09-06T14:22:23.698389",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
