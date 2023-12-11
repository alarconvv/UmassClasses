Appendix S1.
Metadata and mass estimates of volumetic-density (VD) implementations between generated between 1905 and 2019.

Appendix S1 contains the data used in the study along with additional results

Key to file:
	Sheet 1: Full Dataset
		Text colours: black, viable data; orange, excluded data (e.g. no measurements)
		Clade.1: Broad clade categorisation: Ornithischia, Sauropodomorpha, Theropoda
		Clade.2: Refined clade categorisation**
			Ornithischia: Ankylosauria, Marginocephalia, Ornithopoda, Stegosauria, other Ornithischia
			Sauropodomorpha: Brachiosauridae, Diplodocoidea, Eursauropoda, Macronaria, Neosauropoda, Titanosauroidea, other Sauropodomorpha
			Theropoda: Allosauroidea, Carcharodontosauridae, Ceratosauria, Coelophysoidea, Coelurosauria, Maniraptoriformes, Megalosauroidea, Tyrannosauroidea, other Theropoda 
			**In some cases, taxa could not be attributed to a more refined clade and were assigned to their respective Clade.1 designations.
		EBM.ref: Reference for the estimated body mass (EBM).
		EBM.yr: Year the EBM was published.
		Method: VD approach used to generate the recontruction, as detailed in the review.
		Taxon: Associated species name
		EBM.ref.sp: Associated specimen number, if provided, upon which the VD reconstruction was based.
		BM.g: VD body mass estimate in grams
		mature: Where the EBM.ref.sp was designated as skeletally mature (Y) or not (N)
		BM.Qual: VD model identifier, as specified in the associated EBM.ref. min, minimum; max, maximum.
		Meas.sp: Specimen on which the limb measurements are based.
		Match: ? Partial Match, x Perfect Match, and 'blank' no matching specimen
		Gait: Indication of whether to use the bipedal (bip) or quadrupedal (quad) ES models.
		HCFC: Combined humeral and femoral circumferences (quad only)
		HC: Humeral circumference in millimetres (quad only)
		FC: Femoral circumference in  millimetres
		Hybrid.CF2004: x denotes VD models used in the hybrid models of Christiansen & Farina (2004)
		Hybrid.MCF2004: x denotes VD models used in the hybrid models of Mazzetta et al. (2004)
		Hybrid.TH2007: x denotes VD models used in the hybrid models of Therrien & Henderson (2007)
		Hybrid.OH2012: x denotes VD models used in the hybrid models of O'Gorman & Hone (2012)
		Comments: Any qualifications needed with regards to either the VD reconstruction or the limb measurements, along with compartive femoral length (FL) and humeral length (HL) measurements.
	Sheet 2: Outliers
		List of VD-based body masses that occur outside of the 95% prediction intervals of the ES standard. List is in decreasing order of the absolute residual values. Columns as per Full Dataset with the addition of:
		logQE: Log10 body mass estimate derived from either the quadrupedal or bipedal ES models.
		QE: Antilog of logQE (in grams)
		QE+/-25%: Per cent prediction error of the QE (approx. 25%)
		logqQE: Log10 body mass estimate derived from either the quadratic quadrupedal or bipedal ES models.
		qQE: Antilog of logqQE (in grams)
		qQE+/-25%: Per cent prediction error of the qQE (approx. 25%)
		Absolute Residuals: Residual deviation between log10(BM.g) and logQE
 in absolute terms.	
	Sheet 3: Hybrids
		List of specimens whose mass was estimated using a hybrid model. Columns as per Full Dataset
		BM.Qual: Typically identifies the equations used. Equations 1 to 10 and Multiple Regression are from Mazzetta et al. (2004), whereas the remaining equations are from Christiansen & Farina (2004). For the entries pertaining to Therrien & Henderson (2007), qualifications represent maximum and minimum skull lengths used in that study.
		Details about the equations can be found in associated references. Abbreviations: 
											biv, bivariate equation
											FAPD, femoral shaft anteroposterior diameter
											FdistLMD, femoral distal mediolateral diameter
											FIAPD, fibular shaft anteroposterior diameter
											FIdistAPD, fibular distal anteroposterior diamter
											FIdistLMD, fibular distal mediolateral diameter
											FILMD, fibular shaft meidolateral diameter
											FIproxAPD, fibular proximal anteroposterior diameter
											FIP, fibular shaft perimeter (circumference)
											FL, femoral length
											FLMD, femoral shaft mediolateral diameter
											FP, femoral shaft perimeter (circumference)
											mult, multivariate equation
											TAPD, tibial shaft anteroposterior diameter
											TdistLMD, tibial distal mediolateral diameter
											TLMD, tibial mediolateral diameter
											TP, tibial shaft perimeter (circumference)
		Methods: Names follow those used in the review; however, the asterisk denotes that these models were generated via hybrid equations that were based on VD reconstructions generated through the method identified in this column.
	Sheet 4: TH2007
		List of body mass estimates generated through Therrien & Henderson's (2007) skull length-to-body mass hybrid model. See R source code (Appendix S2) for more details.
	
	
		