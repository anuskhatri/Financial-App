from mftool import Mftool
mf = Mftool()
amc_details = mf.get_all_amc_profiles(True)
print(amc_details)